resource "google_compute_instance" "radditm" {
  name         = "raddit-instance"
  machine_type = "n1-standard-1"
  zone         = "europe-central2-a"

  # boot disk specifications
  boot_disk {
    initialize_params {
      image = "raddit-base" // use image built with Packer
    }
  }

  # networks to attach to the VM
  network_interface {
    network = "default"
    access_config {} // use ephemaral public IP
  }
}

resource "google_compute_project_metadata_item" "radditm" {
  key   =  "ssh-keys" 
  value = "raddit-user:${file("~/.ssh/raddit-user.pub")}" // path to ssh key file
}

resource "google_compute_firewall" "radditm" {
  name    = "allow-raddit-tcp-9292"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
}