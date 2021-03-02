data "template_file" "userdata" {
  template = file("userdata.tpl")
  vars = {
    region = var.region
  }
}