# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone
# cf-terraforming -z $CLOUDFLARE_ZONE_ID -e $CLOUDFLARE_EMAIL -k $CLOUDFLARE_KEY zone
resource "cloudflare_zone" "donmai_us" {
  account_id = var.cloudflare_account_id
  zone   = "donmai.us"
  paused = false
  plan   = "pro"
  type   = "full"
}

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec
# https://support.cloudflare.com/hc/en-us/articles/360006660072
# https://www.namecheap.com/support/knowledgebase/article.aspx/9722/2232/managing-dnssec-for-domains-pointed-to-custom-dns/
resource "cloudflare_zone_dnssec" "donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
}

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override
# cf-terraforming -z $CLOUDFLARE_ZONE_ID -e $CLOUDFLARE_EMAIL -k $CLOUDFLARE_KEY zone_settings_override
resource "cloudflare_zone_settings_override" "donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id

  settings {
    #
    # https://dash.cloudflare.com/${CLOUDFLARE_ACCOUNT_ID}/donmai.us/caching/configuration
    #

    # https://support.cloudflare.com/hc/en-us/articles/200168436-Understanding-Cloudflare-Always-Online
    always_online = "off"

    # https://support.cloudflare.com/hc/en-us/articles/200168276-Understanding-Browser-Cache-TTL
    # 0 = "Respect existing headers"
    browser_cache_ttl = 0

    # https://support.cloudflare.com/hc/en-us/articles/200168256-Understand-Cloudflare-Caching-Level
    # aggressive = "Delivers a different resource each time the query string changes."
    cache_level = "aggressive"

    # https://support.cloudflare.com/hc/en-us/articles/200168246-Understanding-Cloudflare-Development-Mode
    development_mode = "off"

    #
    # https://dash.cloudflare.com/${CLOUDFLARE_ACCOUNT_ID}/donmai.us/ssl-tls
    #

    # https://support.cloudflare.com/hc/en-us/articles/204144518-SSL-FAQ#h_a61bfdef-08dd-40f8-8888-7edd8e40d156
    always_use_https = "off"

    # https://support.cloudflare.com/hc/en-us/articles/227227647-How-do-I-use-Automatic-HTTPS-Rewrites-
    automatic_https_rewrites = "off"

    min_tls_version = "1.2"

    # https://support.cloudflare.com/hc/en-us/articles/227253688-Understanding-Opportunistic-Encryption
    opportunistic_encryption = "on"

    # https://support.cloudflare.com/hc/en-us/articles/204183088-Understanding-HSTS-HTTP-Strict-Transport-Security-
    # HSTS header
    security_header {
      enabled            = false
      include_subdomains = false
      max_age            = 0
      nosniff            = false
      preload            = false
    }

    # https://support.cloudflare.com/hc/en-us/articles/200170416
    ssl = "full"

    tls_1_3 = "zrt"

    # https://dash.cloudflare.com/${CLOUDFLARE_ACCOUNT_ID}/donmai.us/ssl-tls/client-certificates
    # https://developers.cloudflare.com/ssl/client-certificates
    tls_client_auth = "off"

    #
    # https://dash.cloudflare.com/${CLOUDFLARE_ACCOUNT_ID}/donmai.us/speed/optimization
    #

    # https://support.cloudflare.com/hc/en-us/articles/200168396
    brotli = "on"

    # https://support.cloudflare.com/hc/en-us/articles/200169876
    minify {
      css  = "off"
      html = "off"
      js   = "off"
    }

    # https://support.cloudflare.com/hc/en-us/articles/219178057-Configuring-Cloudflare-Mirage
    mirage = "off"

    # https://support.cloudflare.com/hc/en-us/articles/200168336
    mobile_redirect {
      mobile_subdomain = ""
      status           = "off"
      strip_uri        = false
    }

    # https://support.cloudflare.com/hc/en-us/articles/360000607372-Using-Cloudflare-Polish-to-compress-images
    polish = "off"
    webp   = "off"

    # https://support.cloudflare.com/hc/en-us/articles/206776707
    prefetch_preload = "off"

    # https://support.cloudflare.com/hc/en-us/articles/200168056-What-does-Rocket-Loader-do-
    rocket_loader = "off"

    #
    # https://dash.cloudflare.com/${CLOUDFLARE_ACCOUNT_ID}/donmai.us/firewall/settings
    #

    # https://support.cloudflare.com/hc/en-us/articles/200170086-Understanding-the-Cloudflare-Browser-Integrity-Check
    browser_check = "off"

    # https://support.cloudflare.com/hc/en-us/articles/200170136-Understanding-Cloudflare-Challenge-Passage-Captcha-
    # Applies to firewall rules and IP access rules, not WAF rules.
    challenge_ttl = 86400 # 1 day

    # https://support.cloudflare.com/hc/en-us/articles/115001992652
    privacy_pass = "on"

    # https://support.cloudflare.com/hc/en-us/articles/200170056-Understanding-the-Cloudflare-Security-Level
    # Low: Challenges only the most threatening visitors
    security_level = "essentially_off"

    # https://support.cloudflare.com/hc/en-us/articles/200172016-Understanding-the-Cloudflare-Web-Application-Firewall-WAF-
    waf = "on"

    #
    # https://dash.cloudflare.com/${CLOUDFLARE_ACCOUNT_ID}/donmai.us/dns
    #

    # https://blog.cloudflare.com/introducing-cname-flattening-rfc-compliant-cnames-at-a-domains-root/
    cname_flattening = "flatten_at_root"

    #
    # https://dash.cloudflare.com/${CLOUDFLARE_ACCOUNT_ID}/donmai.us/network
    #

    # https://www.cloudflare.com/website-optimization/http2/what-is-http2/
    http2 = "on"

    # https://developers.cloudflare.com/http3/
    http3 = "on"

    # https://support.cloudflare.com/hc/en-us/articles/200172516#h_51422705-42d0-450d-8eb1-5321dcadb5bc
    # 100mb max upload size (100mb is the max on the Pro plan).
    max_upload = 100 # megabytes

    # https://support.cloudflare.com/hc/en-us/articles/203306930-Understanding-Cloudflare-Tor-support-and-Onion-Routing
    opportunistic_onion = "on"

    # https://support.cloudflare.com/hc/en-us/articles/229666767-Understanding-and-configuring-Cloudflare-s-IPv6-support#h_877db671-916a-4085-9676-8eb27eaa2a91
    pseudo_ipv4 = "off"

    # https://www.cloudflare.com/website-optimization/web-sockets/
    websockets = "on"

    # https://blog.cloudflare.com/introducing-0-rtt/
    zero_rtt = "on"

    #
    # https://dash.cloudflare.com/${CLOUDFLARE_ACCOUNT_ID}/donmai.us/content-protection
    #

    # https://support.cloudflare.com/hc/en-us/articles/200170016-What-is-Email-Address-Obfuscation-
    email_obfuscation = "off"

    # https://support.cloudflare.com/hc/en-us/articles/200170026-Understanding-Cloudflare-Hotlink-Protection
    hotlink_protection = "off"

    # https://support.cloudflare.com/hc/en-us/articles/200170036-What-does-Server-Side-Excludes-SSE-do-
    server_side_exclude = "off"
  }
}
