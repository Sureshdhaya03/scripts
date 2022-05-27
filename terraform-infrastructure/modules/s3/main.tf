
#s3
resource "aws_s3_bucket" "md5-bucket-001" {
  bucket = "md5-bucket-001"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_acl" "access" {
  bucket = aws_s3_bucket.md5-bucket-001.id
  acl = "private"
}
resource "aws_s3_bucket_object" "md5-bucket-001" {
  for_each = fileset("D:/python_md5/", "**")
  bucket = "md5-bucket-001"
  key = each.value
  source = "D:/python_md5/${each.value}"
}
