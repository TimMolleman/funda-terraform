resource "aws_ecr_repository" "funda-link-scraper" {
  name                 = "funda-link-scraper"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "funda-link-cleaner" {
  name                 = "funda-link-cleaner"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "funda-history-link-cleaner" {
  name                 = "funda-history-link-cleaner"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "funda-model-trainer" {
  name                 = "funda-model-trainer"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "funda-api" {
  name                 = "funda-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}