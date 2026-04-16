# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone
# cf-terraforming -z $CLOUDFLARE_ZONE_ID -e $CLOUDFLARE_EMAIL -k $CLOUDFLARE_KEY zone
resource "cloudflare_zone" "donmai_us" {
  account = {
    id = var.cloudflare_account_id
  }
  name   = "donmai.us"
  paused = false
}

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec
# https://support.cloudflare.com/hc/en-us/articles/360006660072
# https://www.namecheap.com/support/knowledgebase/article.aspx/9722/2232/managing-dnssec-for-domains-pointed-to-custom-dns/
resource "cloudflare_zone_dnssec" "donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  status = "active"
}

resource "cloudflare_zone_setting" "donmai_us_always_online" {
  setting_id = "always_online"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_browser_cache_ttl" {
  setting_id = "browser_cache_ttl"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = 0
}

resource "cloudflare_zone_setting" "donmai_us_cache_level" {
  setting_id = "cache_level"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "aggressive"
}

resource "cloudflare_zone_setting" "donmai_us_development_mode" {
  setting_id = "development_mode"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_always_use_https" {
  setting_id = "always_use_https"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_automatic_https_rewrites" {
  setting_id = "automatic_https_rewrites"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_min_tls_version" {
  setting_id = "min_tls_version"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "1.2"
}

resource "cloudflare_zone_setting" "donmai_us_opportunistic_encryption" {
  setting_id = "opportunistic_encryption"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_security_header" {
  setting_id = "security_header"
  zone_id    = cloudflare_zone.donmai_us.id
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

resource "cloudflare_zone_setting" "donmai_us_ssl" {
  setting_id = "ssl"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "full"
}

resource "cloudflare_zone_setting" "donmai_us_tls_1_3" {
  setting_id = "tls_1_3"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "zrt"
}

resource "cloudflare_zone_setting" "donmai_us_tls_client_auth" {
  setting_id = "tls_client_auth"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_brotli" {
  setting_id = "brotli"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_mirage" {
  setting_id = "mirage"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_polish" {
  setting_id = "polish"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_webp" {
  setting_id = "webp"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_prefetch_preload" {
  setting_id = "prefetch_preload"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_rocket_loader" {
  setting_id = "rocket_loader"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_browser_check" {
  setting_id = "browser_check"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_challenge_ttl" {
  setting_id = "challenge_ttl"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = 86400
}

resource "cloudflare_zone_setting" "donmai_us_privacy_pass" {
  setting_id = "privacy_pass"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_security_level" {
  setting_id = "security_level"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "essentially_off"
}

resource "cloudflare_zone_setting" "donmai_us_waf" {
  setting_id = "waf"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_cname_flattening" {
  setting_id = "cname_flattening"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "flatten_at_root"
}

resource "cloudflare_zone_setting" "donmai_us_http2" {
  setting_id = "http2"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_http3" {
  setting_id = "http3"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_max_upload" {
  setting_id = "max_upload"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = 100
}

resource "cloudflare_zone_setting" "donmai_us_opportunistic_onion" {
  setting_id = "opportunistic_onion"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_pseudo_ipv4" {
  setting_id = "pseudo_ipv4"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_websockets" {
  setting_id = "websockets"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_0rtt" {
  setting_id = "0rtt"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "on"
}

resource "cloudflare_zone_setting" "donmai_us_email_obfuscation" {
  setting_id = "email_obfuscation"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_hotlink_protection" {
  setting_id = "hotlink_protection"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_zone_setting" "donmai_us_server_side_exclude" {
  setting_id = "server_side_exclude"
  zone_id    = cloudflare_zone.donmai_us.id
  value      = "off"
}

resource "cloudflare_tiered_cache" "donmai_us_tiered_cache" {
  zone_id = cloudflare_zone.donmai_us.id
  value = "on"
}