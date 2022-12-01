# KMS encryption of webhok url
resource "aws_kms_key" "url_encrypt" {
  description = "KMS key for notify-slack endpoints"
}

