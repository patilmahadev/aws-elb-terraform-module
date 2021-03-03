resource "aws_key_pair" "mykey" {
  public_key = var.public_key
  key_name = "${var.prefix}-mykey"
}

resource "aws_instance" "myinstance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.mykey.id
  vpc_security_group_ids = [aws_security_group.myec2sg.id]
  subnet_id = var.public_subnet_id
  user_data = var.user_data
  count = 2
  tags = {
    Name = "${var.prefix}-web-${format("%02d", count.index + 1)}"
    Org = "remotex"
  }
}