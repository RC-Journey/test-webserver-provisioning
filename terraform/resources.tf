data "digitalocean_ssh_key" "pixelbook" {
  name = "pixelbook"
}

resource "digitalocean_droplet" "rcjourney_test_server" {
  image  = var.droplet_image
  name   = "rcjourney.org.test"
  region = var.region
  size   = var.droplet_size
  ssh_keys = [
    data.digitalocean_ssh_key.pixelbook.id,
  ]
  tags = [
    "webserver",
    "rc-journey"
  ]
}

resource "digitalocean_firewall" "rcjourney_firewall" {
  name        = "rcjourney-firewall"
  droplet_ids = [digitalocean_droplet.rcjourney_test_server.id]
  inbound_rule {
    protocol   = "tcp"
    port_range = "22"
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

output "public_ip_server" {
  value = digitalocean_droplet.rcjourney_test_server.ipv4_address
}