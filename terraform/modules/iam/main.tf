resource "aws_iam_policy" "s3_access_policy" {
  name   = "${var.project_name}-s3access-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "s3:DeleteObject"
      ],
      "Resource": [
          "arn:aws:s3:::${var.S3ID}",
          "arn:aws:s3:::${var.S3ID}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "s3_access_role" {
  name               = "${var.project_name}-ec2-role"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}



resource "aws_iam_instance_profile" "s3_access_instance_profile" {
  //  name = "${var.project_name}-instanceprofile"
  path = "/"
  name = aws_iam_role.s3_access_role.name
  role = aws_iam_role.s3_access_role.name
}



