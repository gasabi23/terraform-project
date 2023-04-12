resource "aws_eip" "first-eip" {
 vpc      = true
 
}

resource "aws_instance" "myec2" {
   //name = var.intance_name
   ami = data.aws_ami.amzlinux2.id
   instance_type = var.inst_type
   key_name = var.key_pair
   vpc_security_group_ids  = [aws_security_group.dynamicsg.id]
}

/*   provisioner "remote-exec" {
     inline = [
       "sudo yum -y install nano"
     ]
   }
   provisioner "remote-exec" {
       when    = destroy
       inline = [
         "sudo yum -y remove nano"
       ]
     }
     
   connection {
     type = "ssh"
     user = "ec2-user"
     private_key = file("./class.pem")
     host = self.public_ip
   } */


resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}  
  