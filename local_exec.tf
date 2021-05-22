resource "null_resource" "auth" {
  depends_on = [aws_ecr_repository.dl]
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.aws_region} | ${var.container_engine} login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  }
}

resource "null_resource" "build" {
  depends_on = [null_resource.auth]
  provisioner "local-exec" {
    command = "${var.container_engine} build -t ${var.image_name} ."
  }
}

resource "null_resource" "tag" {
  depends_on = [null_resource.build]
  provisioner "local-exec" {
    command = "${var.container_engine} tag ${var.image_name}:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.image_name}:latest"
  }
}

resource "null_resource" "push" {
  depends_on = [null_resource.tag]
  provisioner "local-exec" {
    command = "${var.container_engine} push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.image_name}:latest"
  }
}
