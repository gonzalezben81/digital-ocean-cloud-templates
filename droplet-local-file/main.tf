terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.25.0" # Use the latest stable version
    }
  }
}

# Provider configuration
provider "digitalocean" {
  token = var.do_token # Ensure this variable is defined in your Terraform variables file
}

# Retrieve SSH key information
data "digitalocean_ssh_key" "ssh" {
  name = "finalrstudio" # Replace with the actual name of your SSH key in DigitalOcean
}

# Create the DigitalOcean Droplet
resource "digitalocean_droplet" "local" {
  name   = "local-file-example"
  region = "nyc3" # Replace with your preferred region
  size   = "s-1vcpu-1gb" # Choose a size suitable for your application
  image  = "ubuntu-24-04-x64" # Ensure the image ID is available on DigitalOcean

  ssh_keys = [data.digitalocean_ssh_key.ssh.id]

  # Cloud-init script
  #user_data = file("rstudio-server-install.sh")

  tags = ["rstudio-web-server-local-file"]
}

# Output the droplet IP
output "droplet_ip" {
  value = digitalocean_droplet.local.ipv4_address
}

output "name" {
value = digitalocean_droplet.local.name
}

output "monthly_price" {
value = digitalocean_droplet.local.price_monthly
}
