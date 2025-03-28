terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# registry_auth {
#     address     = "registry-1.docker.io"
#     config_file = pathexpand("~/.docker/config.json")
#   }

#   registry_auth {
#     address             = "registry.my.company.com"
#     config_file_content = var.plain_content_of_config_file
#   }

#   registry_auth {
#     address  = "quay.io:8181"
#     username = "someuser"
#     password = "somepass"
#   }
# }

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx-runner" {
  image = docker_image.nginx.image_id
  name  = "nginx-runner"
  # network_mode = "host"

  ports {
    internal = 80
    external = 8888
  }

}