resource "digitalocean_droplet" "test_server" {
  image    = var.droplet_image
  name     = "rcjourney-test-webserver"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [var.ssh_key_fingerprint]
  tags     = ["webserver", "test"]
}

resource "digitalocean_firewall" "test_firewall" {
  name        = "rcjourney-test-webserver-firewall"
  droplet_ids = [digitalocean_droplet.test_server.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
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
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

output "public_ip_server" {
  value = digitalocean_droplet.test_server.ipv4_address
}
