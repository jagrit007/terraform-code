provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address          = "0.0.0.0:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = ""
      secret_id = ""
    }
  }

}

resource "vault_mount" "kvv2" {
  path        = "kv1"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}


data "vault_kv_secret_v2" "example" {
  mount = "kv1"
  name  = "test-secret"
}

resource "aws_instance" "ec2test" {
  ami           = ""
  instance_type = ""

  tags = {
    randomLabel = data.vault_kv_secret_v2.example.data["test-key"]
  }
}