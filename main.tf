resource "aws_iam_role" "example" {
  name               = "example"
  path = "/"

  assume_role_policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
      {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
      }
    ]
    }
    EOF
}

resource "aws_eks_cluster" "example" {
  name     = "example-cluster"
  role_arn = aws_iam_role.example.arn

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  tags = {
    Owner = "stackguardian"
  }

  outpost_config {
    control_plane_instance_type = "m5d.large"
    outpost_arns                = [data.aws_outposts_outpost.example.arn]
  }
}