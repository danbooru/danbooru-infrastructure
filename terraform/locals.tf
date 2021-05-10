locals {
  servers = {
    inuyama = {
      id   = var.server_ids.inuyama
      ipv4 = data.ovh_dedicated_server.inuyama_donmai_us.ip
    }

    kagamihara = {
      id   = var.server_ids.kagamihara
      ipv4 = data.ovh_dedicated_server.kagamihara_donmai_us.ip
    }

    korone = {
      id   = var.server_ids.korone
      ipv4 = data.ovh_dedicated_server.korone_donmai_us.ip
    }

    oogaki = {
      id   = var.server_ids.oogaki
      ipv4 = data.ovh_dedicated_server.oogaki_donmai_us.ip
    }

    saitou = {
      id   = var.server_ids.saitou
      ipv4 = data.ovh_dedicated_server.saitou_donmai_us.ip
    }

    shima = {
      id   = var.server_ids.shima
      ipv4 = data.ovh_dedicated_server.shima_donmai_us.ip
    }

    isshiki = {
      id   = var.server_ids.isshiki
      ipv4 = tolist(linode_instance.isshiki_donmai_us.ipv4)[0]
    }

    oumae = {
      id   = var.server_ids.oumae
      ipv4 = tolist(linode_instance.oumae_donmai_us.ipv4)[0]
    }

    yukinoshita = {
      id   = var.server_ids.yukinoshita
      ipv4 = tolist(linode_instance.yukinoshita_donmai_us.ipv4)[0]
    }

    naoko = {
      id   = var.server_ids.naoko
      ipv4 = data.external.naoko_donmai_us.result.ip
    }

    kinako = {
      id   = var.server_ids.kinako
      ipv4 = data.external.kinako_donmai_us.result.server_ip
    }

    haachama = {
      id   = var.server_ids.haachama
      ipv4 = data.external.haachama_donmai_us.result.server_ip
    }
  }
}
