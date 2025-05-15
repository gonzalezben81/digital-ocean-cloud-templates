# Create a new SSH key
resource "digitalocean_ssh_key" "default" {
  name       = "rstudio-terraform"
  public_key = file("/home/<user-name>/.ssh/id_rsa.pub")
}
