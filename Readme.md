# About the Project

This Project will provision all the dynamic resources in Amazon WebServices (AWS) cloud which you can destroy and create very often. Hence the name Cattle.

This will create the following resource
* Application Load Balancer
* ALB Listener
* ALB Target Group
* Security Groups
* IAM Roles
* Elastic Container Service - Task and Service
* Scaling Policies

This solution also uses terraform s3 bucket to store state files.This file contains a custom JSON format that records a mapping from the Terraform resources in your templates to the representation of those resources in the real world.

&nbsp;

# Built with
This project is mainly built with terraform version 13.7</br>
It will deploy resources on AWS cloud.

&nbsp;

# Getting started
To run this solution successfully, you should follow the below steps

&nbsp;

You need to install terraform 13.7</br>
</br>
Please Visit the below link to download terraform </br>
.[Download Terraform]: https://releases.hashicorp.com/terraform/0.13.7/

</br>
Please Visit the below link to install terraform </br>
[Install Terraform]: https://learn.hashicorp.com/tutorials/terraform/install-cli

&nbsp;

# Usage
Please follow the instructions in the below steps to run the solution

* Follow the steps in getting started section thoroughly
* Refer to the **description** section in **variables.tf** for all the variables that need to be passed.
* create and pass the aws credentials to variables **access_key** and **secret_key**
* pass the aws region to the variable **region**
* run the below commands to execute terraform

Initiate terraform
``` terraform
terraform init
```
Create a plan of all the resources that are to be deployed to aws and verify before execution
``` terraform
terraform plan
```
you can use the below command to create all the resources
``` terraform
terraform apply
```
you can also use the below command to destroy all the resources
``` terraform
terraform destroy
```

&nbsp;
# contributing
If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request to the main branch

&nbsp;

# Acknowledgement
https://aws.amazon.com/alb/ </br>
https://aws.amazon.com/iam/ </br>
https://aws.amazon.com/ecs/</br>
https://www.terraform.io/intro

