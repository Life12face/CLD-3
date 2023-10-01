
# Variables
variable "bucket_name_prefix" {
  description = "Prefix for the S3 bucket name"
  default     = "bootcamp32"
}

variable "environment" {
  description = "Environment (e.g., Dev, Prod)"
  default     = "Dev"
}

variable "enable_versioning" {
  description = "Enable S3 bucket versioning (true/false)"
  default     = true
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.bucket_name_prefix}-${var.environment}"
  acl    = "private"

  tags = {
    Name        = "Sekou backend"
    Environment = var.environment
  }
}

# KMS Key
resource "aws_kms_key" "my_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

# Bucket Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.my_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# S3 Bucket Versioning
resource "aws_s3_bucket_versioning" "versioning_config" {
  bucket = aws_s3_bucket.my_bucket.id
  enabled = var.enable_versioning
}



