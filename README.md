# Funda Housing Price Prediction Project (Terraform/IaC)

Practice project for setting up a data infrastructure for gathering data, doing some operations on it,
training a model, and then making it available via an API. Primary tooling used for this are Apache Airflow for orchestration of
several AWS services (mainly Lambdas), AWS Lambda in combination with Python and FastAPI for creating the API endpoints.
This FastAPI service is being hosted via AWS API Gateway and Lambda.

For the project, basic housing information of the Dutch real-estate website [Funda](https://www.funda.nl/) is scraped and saved
to an Amazon S3 bucket. After this some transformations are done, and a model is trained, all using AWS Lambda functions
[(see repository)](https://github.com/TimMolleman/funda-link-scraper). The trained  model is also saved to S3 and is then exposed for predictions via the 
API [(see repository)](https://github.com/TimMolleman/funda-api). To schedule all lambdas and to do a number of other
transformations Apache Airflow is used [(see repository)](https://github.com/TimMolleman/funda-airflow).

For managing AWS infrastructure reliably and assure re-usability, Terraform is used [(see repository)](https://github.com/TimMolleman/funda-terraform).

## Description
This repository contains the Terraform code for getting all the infrastructure running that is needed for the project
to work.

## Getting Started

### Executing program
To run the Lambda scripts locally it is possible to execute the .tf files by running the following from the root directory:
```
terraform -chdir=terraform init && terraform -chdir=terraform apply
```
It is wise to first also run `terraform -chdir=terraform plan` to see the changes that would happen on the apply command.

## Authors
Tim Molleman