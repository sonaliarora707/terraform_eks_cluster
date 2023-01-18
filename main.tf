variable "cluster_name" {
  default = "example"
  type    = string
}

resource "aws_eks_cluster" "example" {
  depends_on = [aws_cloudwatch_log_group.example]

  enabled_cluster_log_types = ["api", "audit"]
  name                      = var.cluster_name

  tags = {
    "Owner" = "stackguardian"
  }
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}