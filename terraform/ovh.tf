# https://registry.terraform.io/providers/ovh/ovh/latest/docs
# https://registry.terraform.io/providers/ovh/ovh/latest/docs/data-sources/dedicated_server

data "ovh_dedicated_server" "inuyama_donmai_us" {
  service_name = var.server_ids.inuyama
}

data "ovh_dedicated_server" "korone_donmai_us" {
  service_name = var.server_ids.korone
}

data "ovh_dedicated_server" "oogaki_donmai_us" {
  service_name = var.server_ids.oogaki
}

data "ovh_dedicated_server" "gura_donmai_us" {
  service_name = var.server_ids.gura
}

data "ovh_dedicated_server" "ame_donmai_us" {
  service_name = var.server_ids.ame
}

data "ovh_dedicated_server" "ina_donmai_us" {
  service_name = var.server_ids.ina
}

data "ovh_dedicated_server" "mori_donmai_us" {
  service_name = var.server_ids.mori
}
