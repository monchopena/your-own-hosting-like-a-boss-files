
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 1.22.1"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "docker_swarm" {
  image  = "ubuntu-20-10-x64"
  name   = "docker-swarm"
  region = "fra1"
  size   = "s-4vcpu-8gb"
  ssh_keys = [ "710720" ]
  user_data = file("userdata.yaml")
}

resource "digitalocean_record" "edge" {
  domain = var.domain
  type   = "A"
  name   = "traefik"
  ttl    = "300"
  value  = digitalocean_droplet.docker_swarm.ipv4_address
}

resource "digitalocean_record" "portainer" {
  domain = var.domain
  type   = "A"
  name   = "portainer"
  ttl    = "300"
  value  = digitalocean_droplet.docker_swarm.ipv4_address
}

output "connect_ssh" {
  description = "How to connect to the New Server"
  value = "ssh root@${digitalocean_droplet.docker_swarm.ipv4_address}"
}