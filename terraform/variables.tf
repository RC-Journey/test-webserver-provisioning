variable "do_token" {
  description = "Digital Ocean API Token"
  sensitive   = true
}

variable "ssh_key_fingerprint" {
  description = "Fingerprint SSH public key stored on Digital Ocean"
  sensitive   = true
}

variable "droplet_region" {
  description = "Digital Ocean Region"
  default     = "nyc3"
}

variable "droplet_image" {
  description = "Digital Ocean droplet image name"
  default     = "ubuntu-20-04-x64"
}

variable "droplet_size" {
  description = "Droplet size for server"
  default     = "s-1vcpu-2gb-intel"
}
