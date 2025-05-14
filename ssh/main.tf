terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.25.0" # Use the latest stable version
    }
  }
}

# Create a new SSH key
resource "digitalocean_ssh_key" "default" {
  name       = "rstudio-terraform"
  public_key = file("/home/ben/.ssh/id_rsa.pub")
}
