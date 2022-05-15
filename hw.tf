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
}
resource "yandex_compute_instance" "vm-2" {
  name = "prod"

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
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}


output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}


