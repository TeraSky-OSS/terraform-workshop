#!/bin/bash

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is required but not installed. Please install jq first."
    exit 1
fi

# Check if accounts.csv exists
if [ ! -f "accounts.csv" ]; then
    echo "accounts.csv not found. Please create it with the required format."
    exit 1
fi

# Fetch Labs-Admin credentials from Secrets Manager
echo "Fetching Labs-Admin credentials from Secrets Manager..."
LABS_ADMIN_CREDS=$(aws secretsmanager get-secret-value \
    --secret-id labs-admin-credentials \
    --region eu-west-1 \
    --query 'SecretString' \
    --output text)

if [ $? -ne 0 ]; then
    echo "Failed to retrieve Labs-Admin credentials from Secrets Manager."
    exit 1
fi

echo "Successfully retrieved Labs-Admin credentials."

# Create a CSV file for storing all credentials
echo "Account ID,User Name,User Password,User Access Key,User Secret Access Key" > all_credentials.csv

# Skip header line and process each account
tail -n +2 accounts.csv | while IFS=, read -r account_id account_name email
do
    # Remove quotes from the values
    account_id=$(echo $account_id | tr -d '"')
    account_name=$(echo $account_name | tr -d '"')
    email=$(echo $email | tr -d '"')
    
    echo "Processing account: $account_name ($account_id)"

    # Export the Labs-Admin credentials
    export AWS_ACCESS_KEY_ID=$(echo $LABS_ADMIN_CREDS | jq -r .AWS_ACCESS_KEY_ID)
    export AWS_SECRET_ACCESS_KEY=$(echo $LABS_ADMIN_CREDS | jq -r .AWS_SECRET_ACCESS_KEY)
    unset AWS_SESSION_TOKEN
    
    # Assume the LabExecutionRole in the target account
    echo "Assuming LabExecutionRole in account $account_id..."
    ASSUMED_ROLE=$(aws sts assume-role \
        --role-arn "arn:aws:iam::${account_id}:role/LabExecutionRole" \
        --role-session-name "TerraformWorkshopSetup" \
        --region us-east-1)
    
    if [ $? -ne 0 ]; then
        echo "Failed to assume LabExecutionRole in account $account_id. Skipping this account."
        continue
    fi
    
    # Export the temporary credentials
    export AWS_ACCESS_KEY_ID=$(echo $ASSUMED_ROLE | jq -r .Credentials.AccessKeyId)
    export AWS_SECRET_ACCESS_KEY=$(echo $ASSUMED_ROLE | jq -r .Credentials.SecretAccessKey)
    export AWS_SESSION_TOKEN=$(echo $ASSUMED_ROLE | jq -r .Credentials.SessionToken)
    
    # Set variables for S3 bucket
    S3_BUCKET_NAME="terraform-workshop-tf-states-${account_id}"
    S3_BUCKET_REGION="eu-west-1"
    
    # Check if S3 bucket already exists
    echo "Checking if S3 bucket exists: $S3_BUCKET_NAME"
    if aws s3api head-bucket --bucket $S3_BUCKET_NAME 2>/dev/null; then
        echo "S3 bucket $S3_BUCKET_NAME already exists. Skipping creation."
    else
        echo "Creating S3 bucket for Terraform state: $S3_BUCKET_NAME"
        
        # Create S3 bucket
        aws s3api create-bucket \
            --bucket $S3_BUCKET_NAME \
            --region $S3_BUCKET_REGION \
            --create-bucket-configuration LocationConstraint=$S3_BUCKET_REGION
        
        # Enable versioning on the bucket
        aws s3api put-bucket-versioning \
            --bucket $S3_BUCKET_NAME \
            --versioning-configuration Status=Enabled
        
        echo "S3 bucket created and versioning enabled."
    fi
    
    # Create backend configuration file
    cat > backend.tfvars << EOF
bucket       = "$S3_BUCKET_NAME"
key          = "terraform.tfstate"
region       = "$S3_BUCKET_REGION"
encrypt      = true
use_lockfile = true
EOF
    
    # Initialize and apply Terraform with S3 backend
    echo "Initializing Terraform with S3 backend..."
    terraform init -backend-config=backend.tfvars -reconfigure
    
    echo "Applying Terraform configuration..."
    terraform apply -auto-approve
    
    # Get the outputs from Terraform
    kubeconfig_cmd=$(terraform output -raw eks_update_kubeconfig_command)
    iam_user_access_key=$(terraform output -raw iam_user_access_key)
    iam_user_secret_access_key=$(terraform output -raw iam_user_secret_access_key)
    iam_user_password=$(terraform output -raw iam_user_password)
    
    # Add credentials to the CSV file
    echo "$account_id,Terraform-Workshop-User,$iam_user_password,$iam_user_access_key,$iam_user_secret_access_key" >> all_credentials.csv
    
    # Create a setup instructions file for each account
    cat > "../setup_instructions_${account_name}.txt" << EOF
Account Setup Instructions for $account_name
=========================================

1. Configure AWS CLI with IAM user credentials:
   aws configure --profile "$account_name"
   AWS Access Key ID: $iam_user_access_key
   AWS Secret Access Key: $iam_user_secret_access_key
   Default region name: us-east-1
   Default output format: json

2. Login to AWS Console:
   URL: https://$account_id.signin.aws.amazon.com/console
   Username: Terraform-Workshop-User
   Password: $iam_user_password

3. Update kubeconfig:
   $kubeconfig_cmd

4. Verify access:
   kubectl get nodes

Note: Keep these credentials secure and rotate them after the workshop.
EOF
    
    echo "Setup completed for $account_name"
    echo "----------------------------------------"
done

# Set proper permissions for the CSV file
chmod 600 all_credentials.csv

echo "All accounts processed. Credentials saved in all_credentials.csv"
echo "Please keep this file secure and rotate the credentials after the workshop."