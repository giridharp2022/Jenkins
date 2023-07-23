data "aws_subnet" "private-subnet" {
  filter {
    name   = "tag:Name"    
    values = ["*private*1*"]
  }
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

data "aws_iam_policy" "required-policy" {
  name = "AmazonSSMManagedEC2InstanceDefaultPolicy"
}

resource "aws_iam_role" "system-role" {
  name = "ec2-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach-ssm-ec2" {
  role       = aws_iam_role.system-role.name
  policy_arn = data.aws_iam_policy.required-policy.arn
  depends_on = [aws_iam_role.system-role]
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.system-role.name
  depends_on = [aws_iam_role_policy_attachment.attach-ssm-ec2]
}

resource "aws_key_pair" "mykey" {
  key_name   = var.keyname
  public_key = var.pubkey
  tags= {
    Name = var.keyname
  }
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = var.instancetype
  subnet_id     = data.aws_subnet.private-subnet.id
  key_name      = aws_key_pair.mykey.id
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  user_data     = "${file("jenkins.sh")}"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  depends_on = [aws_security_group.jenkins-sg,aws_key_pair.mykey,aws_iam_role.system-role,aws_iam_instance_profile.test_profile]
  tags = {
    Name = var.ec2_tag_name
  }
}