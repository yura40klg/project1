terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "AQAEA7qiLjVSAATuwbFtahevsEFnigdkralgVB8"
  cloud_id  = "b1gvgh0p5jlr8i53p2m7"
  folder_id = "b1gra9c1ucqnfnmki3lj"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {
  name = "dev"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8sc0f4358r8pt128gg"
    }
  }

 network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat = true
   }

  metadata = {
   user-data = file("user_config.yml")
  }
  provisioner "remote-exec" {
    inline = ["sudo apt update"]
   connection {
      type        = "ssh"
      user        = "yura"
      private_key = "${file(var.ssh_key_private)}"
      host = "${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
    }
  }
provisioner "file" {
    source      = "./Dev/Dockerfile"
    destination = "/tmp/Dockerfile"
  }
  connection {
      type        = "ssh"
      user        = "yura"
      private_key = "${file(var.ssh_key_private)}"
      host = "${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
    }   
}
resource "yandex_compute_instance" "vm-2" {
  name = "prod"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8sc0f4358r8pt128gg"
    }
  }

 network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat = true
   }

  metadata = {
   user-data = file("user_config.yml")
  }
provisioner "remote-exec" {
    inline = ["sudo apt update"]
   connection {
      type        = "ssh"
      user        = "yura"
      private_key = "${file(var.ssh_key_private)}"
      host = "${yandex_compute_instance.vm-2.network_interface.0.nat_ip_address}"
    }
  }
  provisioner "file" {
    source      = "./Prod/Dockerfile"
    destination = "/tmp/Dockerfile"
  }
  connection {
      type        = "ssh"
      user        = "yura"
      private_key = "${file(var.ssh_key_private)}"
      host = "${yandex_compute_instance.vm-2.network_interface.0.nat_ip_address}"
    } 

}

resource "yandex_compute_instance" "vm-3" {
  name = "stage"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8sc0f4358r8pt128gg"
    }
  }

 network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat = true
   }

  metadata = {
   user-data = file("user_config.yml")
  }
provisioner "remote-exec" {
    inline = ["sudo apt update"]
   connection {
      type        = "ssh"
      user        = "yura"
      private_key = "${file(var.ssh_key_private)}"
      host = "${yandex_compute_instance.vm-3.network_interface.0.nat_ip_address}"
    }
  }

}


