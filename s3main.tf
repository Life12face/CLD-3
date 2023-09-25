resource "aws_s3_bucket" "backend" {
  bucket = "bootcamp32-${lower(var.env)}-${random_integer.backend.result}"
  tags = {
    Name        = "Sekou backend"
    Environment = "Dev"
  }
}

#5. KMS for bucket encryption
resource "aws_kms_key" "sekoukey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

#6. Bucket encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "backend" {
  bucket = aws_s3_bucket.backend.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.sekoukey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Random integer for bucket naming convention
resource "random_integer" "backend" {
  min = 1
  max = 100
  keepers = {
    Environment = var.env
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.backend.id
  versioning_configuration {
    status = var.versioning
  }
}




