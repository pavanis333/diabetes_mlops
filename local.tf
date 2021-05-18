resource "null_resource" "auth" {
   depends_on = [ aws_ecr_repository.dl ]
   provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  }
}

resource "null_resource" "build" {
   depends_on = [ null_resource.auth ]
   provisioner "local-exec" {
     command =  "docker build -t deeplearning ."
   }
}

resource "null_resource" "tag" {
   depends_on = [ null_resource.build ]
   provisioner "local-exec" {
     command = "docker tag ${var.image_name}:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/${var.image_name}:latest"
   }
}

resource "null_resource" "push" {
   depends_on = [ null_resource.tag ]
   provisioner "local-exec" {
     command = "docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com/deeplearning:latest"
  }
}
