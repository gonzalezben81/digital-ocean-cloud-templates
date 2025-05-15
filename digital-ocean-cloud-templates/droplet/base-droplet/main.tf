terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.25.0" # Use the latest stable version
    }4224
  }
}

###Retrieve the digital ocean do_token variable that contains the API token
provider "digitalocean" {
  token = var.do_token
}

###Retrieve the ssh key information from the ssh key available from your digital ocean account
data "digitalocean_ssh_key" "ssh" {
  name = "<name-of-ssh-key-from-digital-ocean-dashboard>"
}


###Create the digital ocean droplet
resource "digitalocean_droplet" "example" {
  name   = "example-droplet"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-24-04-x64"
  ssh_keys = [data.digitalocean_ssh_key.ssh.id] 

}
