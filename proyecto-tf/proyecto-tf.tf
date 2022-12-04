terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.16.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine" # Comenta esta linea si eres usuario MacOS o Linux
}

resource "docker_image" "app_postwork" {
  name = "app_postwork"
  build {
    path = "../app/."
    tag = [
      "app_postwork:latest"
    ]
  }

}

resource "docker_container" "app_postwork" {
  image = docker_image.app_postwork.image_id
  name  = "app_postwork-demo"
  ports {
    internal = 5000
    external = 5000
  }
  depends_on = [
    docker_image.app_postwork
  ]
}

