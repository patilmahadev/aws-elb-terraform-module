variable "region" {
  default = "us-east-1"
}

variable "profile" {
  default = "remotex"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "amis" {
  type = map(string)
  default = {
    us-east-1 = "ami-0915bcb5fa77e4892"
    us-east-2 = "ami-09246ddb00c7c4fef"
    us-west-1 = "ami-066c82dabe6dd7f73"
    us-west-2 = "ami-09c5e030f74651050"
  }
}