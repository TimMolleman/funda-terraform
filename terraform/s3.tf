resource "aws_s3_bucket" "funda-airflow" {
  bucket = "funda-airflow"
  acl    = "private"
}