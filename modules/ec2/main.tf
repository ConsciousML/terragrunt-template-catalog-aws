resource "aws_instance" "example" {
  ami           = var.ami
  subnet_id     = var.subnet_id
  instance_type = var.instance_type
  tags          = var.tags
}
