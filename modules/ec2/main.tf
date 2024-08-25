resource "aws_key_pair" "terraform" {
  key_name   = "terraform"
  public_key = file("terraform.pub")
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  tags          = var.tags
  key_name      = aws_key_pair.terraform.key_name
  #   key_name      = var.key_name

  provisioner "file" {
    source      = "./modules/ec2/web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "ls -la /tmp",
      "cat /tmp/web.sh",
      "chmod +x /tmp/web.sh",
      "sudo yum install -y dos2unix",
      "dos2unix /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  connection {
    user        = var.connection_user
    private_key = file("terraform")
    host        = self.public_ip
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip}  > pub_ip.txt "
  }
  lifecycle {
    # create_before_destroy = true
    # prevent_destroy       = true
    ignore_changes = ["tags"]
  }
}

