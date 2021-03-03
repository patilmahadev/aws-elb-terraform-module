resource "aws_elb" "myelb" {
  name = "${var.prefix}-myelb"
  subnets = [var.public_subnet_id, var.private_subnet_id]
  security_groups = [aws_security_group.myelbsg.id]
  instances = aws_instance.myinstance.*.id
  connection_draining = true

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:80/index.html"
    timeout = 3
    unhealthy_threshold = 2
  }
}