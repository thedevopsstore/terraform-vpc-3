
# terraform-vpc-3

This code will create a VPC with two public subnets and two private subnets with internet gateway and natgateway for private subnet to communicate with internet


git clone https://github.com/thedevopsstore/terraform-vpc-3.git

cd terraform-vpc-3

terraform init

terraform plan -var="ENV=<env like dev or stage or prod default is dev>" -var="AWS_REGION=<region default is us-east-1>"
  
terraform apply -var="ENV=<env like dev or stage or prod default is dev>" -var="AWS_REGION=<region default is us-east-1>"
