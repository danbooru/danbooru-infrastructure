# https://console.online.net/en/api/
# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source

data "external" "naoko_donmai_us" {
  program = [
    "env",
    "SCALEWAY_DEDIBOX_API_TOKEN=${var.scaleway_dedibox_api_token}",
    "${path.module}/bin/scaleway-dedibox.sh",
    "server",
    var.server_ids.naoko
  ]
}
