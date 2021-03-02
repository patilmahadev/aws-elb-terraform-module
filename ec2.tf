resource "aws_key_pair" "mykey" {
  public_key = file("mykey.pub")
  key_name = "mykey"
}

resource "aws_instance" "myinstance" {
  ami = lookup(var.amis, var.region)
  instance_type = var.instance_type
  key_name = aws_key_pair.mykey.id
  vpc_security_group_ids = [aws_security_group.myec2sg.id]
  subnet_id = aws_subnet.mypubsub.id
  user_data = data.template_file.userdata.rendered
  count = 2
  tags = {
    Name = "web-${format("%02d", count.index + 1)}"
    Org = "remotex"
  }
}