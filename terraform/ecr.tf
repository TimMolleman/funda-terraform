resource "aws_ecr_repository" "funda-link-scraper" {
  name                 = "funda-link-scraper"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}