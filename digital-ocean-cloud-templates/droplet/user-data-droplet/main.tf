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
resource "digitalocean_droplet" "example" {
  name   = "example-droplet"
  region = "nyc3" # Replace with your preferred region
  size   = "s-1vcpu-1gb" # Choose a size suitable for your application
  image  = "ubuntu-24-04-x64" # Ensure the image ID is available on DigitalOcean

  ssh_keys = [data.digitalocean_ssh_key.ssh.id]

  # Cloud-init script
  user_data = <<EOT
#cloud-config
package_update: true
package_upgrade: true

users:
  - name: ben
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash

packages:
  - nginx
  - r-base
  - rstudio-server

runcmd:
  - systemctl enable nginx
  - systemctl start nginx
  - apt-get update -y
  - apt-get install -y gdebi-core
  - sudo apt-get -y install libcurl4-gnutls-dev libxml2-dev libssl-dev
  - wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.12.0-467-amd64.deb
  - sudo gdebi --n rstudio-server-2024.12.0-467-amd64.deb
  - echo "Installing shiny for R"
  - sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\""
  - ech "Completed installing shiny for R"
  - wget https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.22.1017-amd64.deb
  - sudo gdebi --n shiny-server-1.5.22.1017-amd64.deb
  - sudo apt install net-tools -y
  - sudo apt-get install -y git

write_files:
  - path: /var/www/html/index.html
    content: |
      <!DOCTYPE html>
      <html>
      <head>
          <title>Welcome to Your Droplet!</title>
      </head>
      <body>
          <h1>Hello, DigitalOcean!</h1>
          <p>This page is served by Nginx running on your droplet.</p>
      </body>
      </html>
    permissions: '0644'

final_message: "The system is finally up, and the web server is running!"
EOT

  tags = ["rstudio-web-server"]
}

# Output the droplet IP
output "droplet_ip" {
  value = digitalocean_droplet.example.ipv4_address
}
