variable "aws_region" {
  default = "us-east-1"
}
variable "image_name" {
  default = "deeplearning"
}

variable "container_engine" {
  default = "docker"
}

variable "container_name" {
    default = "diabetes"
}

variable "cluster_name" {
    default = "diabetes_cluster"
}

variable "service_name" {
    default = "diabetes_service"
}