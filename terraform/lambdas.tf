resource "aws_iam_role" "lambda_iam_role" {
  name = "lambda_iam_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution_policy" {
  role       = aws_iam_role.lambda_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "funda-link-scraper" {
  function_name = "funda-link-scraper"
  role = aws_iam_role.lambda_iam_role.arn
  package_type = "Image"
  image_uri = "${aws_ecr_repository.funda-link-scraper.repository_url}:latest"
}

resource "aws_lambda_function" "funda-link-cleaner" {
  function_name = "funda-link-cleaner"
  role = aws_iam_role.lambda_iam_role.arn
  package_type = "Image"
  image_uri = "${aws_ecr_repository.funda-link-cleaner.repository_url}:latest"
}

resource "aws_lambda_function" "funda-history-link-cleaner" {
  function_name = "funda-history-link-cleaner"
  role = aws_iam_role.lambda_iam_role.arn
  package_type = "Image"
  image_uri = "${aws_ecr_repository.funda-history-link-cleaner.repository_url}:latest"
}

resource "aws_lambda_function" "funda-model-trainer" {
  function_name = "funda-model-trainer"
  role = aws_iam_role.lambda_iam_role.arn
  package_type = "Image"
  image_uri = "${aws_ecr_repository.funda-model-trainer.repository_url}:latest"
}