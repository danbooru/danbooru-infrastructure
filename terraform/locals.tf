locals {
  servers = {
    oogaki = {
      id   = var.server_ids.oogaki
      ipv4 = data.ovh_dedicated_server.oogaki_donmai_us.ip
    }

    gura = {
      id   = var.server_ids.gura
      ipv4 = data.ovh_dedicated_server.gura_donmai_us.ip
    }

    ame = {
      id   = var.server_ids.ame
      ipv4 = data.ovh_dedicated_server.ame_donmai_us.ip
    }

    ina = {
      id   = var.server_ids.ina
      ipv4 = data.ovh_dedicated_server.ina_donmai_us.ip
    }

    mori = {
      id   = var.server_ids.mori
      ipv4 = data.ovh_dedicated_server.mori_donmai_us.ip
    }

    kiara = {
      id   = var.server_ids.kiara
      ipv4 = data.ovh_dedicated_server.kiara_donmai_us.ip
    }

    isshiki = {
      id   = var.server_ids.isshiki
      ipv4 = tolist(linode_instance.isshiki_donmai_us.ipv4)[0]
    }

    oumae = {
      id   = var.server_ids.oumae
      ipv4 = tolist(linode_instance.oumae_donmai_us.ipv4)[0]
    }

    naoko = {
      id   = var.server_ids.naoko
      ipv4 = data.external.naoko_donmai_us.result.ip
    }

    haachama = {
      id   = var.server_ids.haachama
      ipv4 = data.external.haachama_donmai_us.result.server_ip
    }

    haachama = {
      id   = var.server_ids.haachama
      ipv4 = data.external.haachama_donmai_us.result.server_ip
    }

    node1_haachama = {
      ipv4 = var.server_ipv4s.node1_haachama
    }

    node2_haachama = {
      ipv4 = var.server_ipv4s.node2_haachama
    }

    node3_haachama = {
      ipv4 = var.server_ipv4s.node3_haachama
    }

    irys = {
      id   = var.server_ids.irys
      ipv4 = data.external.irys_donmai_us.result.server_ip
    }
  }
}
