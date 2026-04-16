# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone
# cf-terraforming -z $CLOUDFLARE_ZONE_ID -e $CLOUDFLARE_EMAIL -k $CLOUDFLARE_KEY zone
resource "cloudflare_zone" "donmai_moe" {
  account = {
    id = var.cloudflare_account_id
  }
  name   = "donmai.moe"
  paused = false
}

resource "cloudflare_zone_setting" "donmai_moe_always_online" {
  setting_id = "always_online"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_browser_cache_ttl" {
  setting_id = "browser_cache_ttl"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = 0
}

resource "cloudflare_zone_setting" "donmai_moe_cache_level" {
  setting_id = "cache_level"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "aggressive"
}

resource "cloudflare_zone_setting" "donmai_moe_development_mode" {
  setting_id = "development_mode"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_always_use_https" {
  setting_id = "always_use_https"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_automatic_https_rewrites" {
  setting_id = "automatic_https_rewrites"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_min_tls_version" {
  setting_id = "min_tls_version"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "1.2"
}

resource "cloudflare_zone_setting" "donmai_moe_opportunistic_encryption" {
  setting_id = "opportunistic_encryption"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_moe_security_header" {
  setting_id = "security_header"
  zone_id    = cloudflare_zone.donmai_moe.id
  value = {
    strict_transport_security = {
      enabled            = false
      include_subdomains = false
      max_age            = 0
      nosniff            = false
      preload            = false
    }
  }
}

resource "cloudflare_zone_setting" "donmai_moe_ssl" {
  setting_id = "ssl"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "full"
}

resource "cloudflare_zone_setting" "donmai_moe_tls_1_3" {
  setting_id = "tls_1_3"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "zrt"
}

resource "cloudflare_zone_setting" "donmai_moe_tls_client_auth" {
  setting_id = "tls_client_auth"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_brotli" {
  setting_id = "brotli"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_moe_rocket_loader" {
  setting_id = "rocket_loader"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_browser_check" {
  setting_id = "browser_check"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_challenge_ttl" {
  setting_id = "challenge_ttl"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = 86400
}

resource "cloudflare_zone_setting" "donmai_moe_privacy_pass" {
  setting_id = "privacy_pass"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_moe_security_level" {
  setting_id = "security_level"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "under_attack"
}

resource "cloudflare_zone_setting" "donmai_moe_http3" {
  setting_id = "http3"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_moe_max_upload" {
  setting_id = "max_upload"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = 100
}

resource "cloudflare_zone_setting" "donmai_moe_opportunistic_onion" {
  setting_id = "opportunistic_onion"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_moe_pseudo_ipv4" {
  setting_id = "pseudo_ipv4"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_websockets" {
  setting_id = "websockets"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_moe_0rtt" {
  setting_id = "0rtt"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_moe_email_obfuscation" {
  setting_id = "email_obfuscation"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_hotlink_protection" {
  setting_id = "hotlink_protection"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_moe_server_side_exclude" {
  setting_id = "server_side_exclude"
  zone_id    = cloudflare_zone.donmai_moe.id
  value      = "off"
}

resource "cloudflare_dns_record" "donmai_moe" {
  zone_id = cloudflare_zone.donmai_moe.id
  type    = "CNAME"
  name    = "donmai.moe"
  content = "danbooru.donmai.us"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www_donmai_moe" {
  zone_id = cloudflare_zone.donmai_moe.id
  type    = "CNAME"
  name    = "www.donmai.moe"
  content = "danbooru.donmai.us"
  ttl     = 1
  proxied = true
}
