terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "tcp://${var.ssh_host}:2375"
}

resource "docker_image" "nginximage" {
  name = "nginx:latest"
}
resource "docker_container" "nginx" {
  image = docker_image.nginximage.latest
  name  = "Nginxhugo2"
  ports {
    internal = 80
    external = 80
  }
}
