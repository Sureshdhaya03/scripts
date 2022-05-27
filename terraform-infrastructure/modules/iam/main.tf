
resource "aws_iam_role" "ec2_assume_role" {
  name               = "ec2_assume_role"
  path               =  "/"
  assume_role_policy = file("${path.module}/config/ec2_role.json")
}

resource "aws_iam_policy" "ec2_assume_policy" {
  name        = "ec2_assume_policy"
  policy      = file("${path.module}/config/s3_policy.json")
}

resource  "aws_iam_role_policy_attachment" "ec2_ec2_policy_attachment" {
  role= aws_iam_role.ec2_assume_role.name
  policy_arn= aws_iam_policy.ec2_assume_policy.arn
}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role	         = aws_iam_role.ec2_assume_role.name
}

