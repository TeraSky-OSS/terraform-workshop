# TL;DR

Build the image with the following command:

```bash
packer init .
packer validate aws-nginx.pkr.hcl
packer inspect aws-nginx.pkr.hcl
packer build aws-nginx.pkr.hcl
```

Once done, create an instance from the image and browse to its public IP address to view the default page.
