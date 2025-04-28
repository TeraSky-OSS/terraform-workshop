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

# Check if create_eks parameter is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <create_eks>"
    echo "  create_eks: true or false to control EKS cluster creation"
    exit 1
fi

CREATE_EKS=$1

# Validate create_eks parameter
if [ "$CREATE_EKS" != "true" ] && [ "$CREATE_EKS" != "false" ]; then
    echo "Error: create_eks must be either 'true' or 'false'"
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
    
    # Initialize and apply Terraform with S3 backend
    echo "Initializing Terraform with S3 backend..."
    terraform init -backend-config="bucket=$S3_BUCKET_NAME" \
                   -backend-config="key=terraform.tfstate" \
                   -backend-config="region=$S3_BUCKET_REGION" \
                   -backend-config="encrypt=true" \
                   -backend-config="use_lockfile=true" \
                   -reconfigure
    
    echo "Destroying Terraform configuration..."
    terraform destroy -auto-approve -var="create_eks_cluster=$CREATE_EKS"
done

echo "All accounts processed."