output "s3_bucket_id" {
    value = aws_s3_bucket.md5-bucket-001.id
}
output "s3_bucket_arn" {
    value = aws_s3_bucket.md5-bucket-001.arn
}
output "s3_bucket_region" {
    value = aws_s3_bucket.md5-bucket-001.region
}
