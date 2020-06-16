
variable "profile" {
  default = "default"
}

variable "instance_type_workers" {
  default = "t2.micro"
}

variable "instance_type_master" {
  default = "t2.medium"
}


variable "region" {
  default = "us-east-1"
}


variable "image_id" {
  default     = "ami-085925f297f89fce1"
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}

variable "amis" {

  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}

variable "docker_version" {
  default = "1.23.1"
}