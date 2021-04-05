# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule
# https://support.cloudflare.com/hc/en-us/articles/218411427-Understanding-and-Configuring-Cloudflare-Page-Rules-Page-Rules-Tutorial-

resource "cloudflare_page_rule" "page_rule_0d0ebaafee60a48da7d1ad1369fbc559" {
  zone_id  = cloudflare_zone.donmai_us.id
  target   = "https://b2.donmai.us/file/*/*"
  priority = 1
  status   = "active"
  actions {
    forwarding_url {
      status_code = 302
      url         = "https://secure.backblaze.com/404notfound"
    }
  }
}

resource "cloudflare_page_rule" "page_rule_4942ec8a1eb5efd2ef2f8fc913f61f97" {
  zone_id  = cloudflare_zone.donmai_us.id
  target   = "https://b2.donmai.us/file/danbooru*/*"
  priority = 2
  status   = "active"
  actions {
    cache_level = "aggressive"
  }
}

resource "cloudflare_page_rule" "page_rule_d233aa0f9beecdda3076f60414cb6ff1" {
  zone_id  = cloudflare_zone.donmai_us.id
  target   = "https://cdn.donmai.us/*"
  priority = 3
  status   = "active"
  actions {
    cache_level = "aggressive"
  }
}

resource "cloudflare_page_rule" "page_rule_bccfb9b07003cc2bfaaccc9dbaca5834" {
  zone_id  = cloudflare_zone.donmai_us.id
  target   = "*.donmai.us/autocomplete*"
  priority = 4
  status   = "active"
  actions {
    cache_level = "cache_everything"
  }
}
