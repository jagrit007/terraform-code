module "ec2_instance" {
  source              = "./ec2_instance"
  security_group_name = "kekkekkeke"
  instance_type       = "t2.micro"
  ami_value           = "ami-084568db4383264d4"
  key_name            = "kekekekekke"
  key_pair_filepath   = "~/terraform_example_key.pub"

}