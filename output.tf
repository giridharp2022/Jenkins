output "vpcid" {
  value = data.aws_vpc.selected.id
}

output "alb-sg" {
   value = aws_security_group.alb-sg.id
}

output "jenkins-sg" {
   value = aws_security_group.jenkins-sg.id
}

output "subnet_id" {
    value = data.aws_subnet.private-subnet.id
}

output "keypairid" {
    value= aws_key_pair.mykey.id
}

output "ec2-private-ip" {
  value       = "${aws_instance.jenkins.*.private_ip}"
}

output "acm_arn" {
    value = aws_acm_certificate.devops.arn
}

output "pubsubnetids" {
    value=[for s in data.aws_subnet.example : s.id]
}