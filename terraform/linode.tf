# https://www.linode.com/docs/guides/import-existing-infrastructure-to-terraform/
# https://registry.terraform.io/providers/linode/linode/latest/docs

# https://registry.terraform.io/providers/linode/linode/latest/docs/resources/instance
resource "linode_instance" "isshiki_donmai_us" {
  label             = "isshiki"
  region            = "us-west"
  type              = "g6-standard-4"
  boot_config_label = "My Debian 8.1 Profile"

  alerts {
    cpu            = 400
    io             = 0
    network_in     = 0
    network_out    = 0
    transfer_quota = 80
  }

  config {
    label       = "My Debian 8.1 Profile"
    kernel      = "linode/latest-64bit"
    root_device = "/dev/sda"

    devices {
      sda {
        disk_label = "Debian 8.1 Disk"
      }

      sdb {
        disk_label = "256MB Swap Image"
      }
    }

    helpers {
      devtmpfs_automount = true
      distro             = true
      modules_dep        = true
      network            = false
      updatedb_disabled  = true
    }
  }

  disk {
    filesystem = "ext4"
    label      = "Debian 8.1 Disk"
    size       = 81664
  }

  disk {
    filesystem = "swap"
    label      = "256MB Swap Image"
    size       = 256
  }
}

resource "linode_instance" "oumae_donmai_us" {
  label             = "oumae"
  region            = "us-west"
  type              = "g6-standard-4"
  boot_config_label = "My Debian 8 Profile"

  alerts {
    cpu         = 90
    io          = 10000
    network_in  = 10
    network_out = 10
  }

  config {
    label       = "My Debian 8 Profile"
    kernel      = "linode/latest-64bit"
    root_device = "/dev/sda"

    devices {
      sda {
        disk_label = "Debian 8 Disk"
      }

      sdb {
        disk_label = "256MB Swap Image"
      }
    }

    helpers {
      devtmpfs_automount = true
      distro             = true
      modules_dep        = true
      network            = false
      updatedb_disabled  = true
    }
  }

  disk {
    filesystem = "ext4"
    label      = "Debian 8 Disk"
    size       = 163584
  }

  disk {
    filesystem = "swap"
    label      = "256MB Swap Image"
    size       = 256
  }
}

resource "linode_instance" "yukinoshita_donmai_us" {
  label             = "yukinoshita"
  region            = "us-west"
  type              = "g6-standard-4"
  boot_config_label = "My Debian 8 Profile"

  alerts {
    cpu         = 0
    io          = 0
    network_in  = 0
    network_out = 0
  }

  config {
    label       = "My Debian 8 Profile"
    kernel      = "linode/latest-64bit"
    root_device = "/dev/sda"

    devices {
      sda {
        disk_label = "Debian 8 Disk"
      }

      sdb {
        disk_label = "256MB Swap Image"
      }
    }

    helpers {
      devtmpfs_automount = true
      distro             = true
      modules_dep        = true
      network            = false
      updatedb_disabled  = true
    }
  }

  disk {
    filesystem = "ext4"
    label      = "Debian 8 Disk"
    size       = 163584
  }

  disk {
    filesystem = "swap"
    label      = "256MB Swap Image"
    size       = 256
  }
}
