# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/firewall_rule
# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/filter
# https://developers.cloudflare.com/firewall/cf-firewall-language

resource "cloudflare_firewall_rule" "allow_known_bots" {
  zone_id     = cloudflare_zone.donmai_us.id
  filter_id   = cloudflare_filter.allow_known_bots.id
  description = "Allow Known Bots"
  action      = "allow"
  priority    = 250
}

# cf.client.bot is search engines and other friendly bots
# https://developers.cloudflare.com/firewall/known-issues-and-faq#bots-currently-detected
resource "cloudflare_filter" "allow_known_bots" {
  zone_id    = cloudflare_zone.donmai_us.id
  expression = "(cf.client.bot)"
}

resource "cloudflare_firewall_rule" "banned_ips" {
  zone_id     = cloudflare_zone.donmai_us.id
  filter_id   = cloudflare_filter.banned_ips.id
  description = "Banned IPs"
  action      = "js_challenge"
  priority    = 500
}

# 2.200.68.92 - spamming "rating:explicit <tag>" searches for non-existent tags
# 34.226.218.10 - spamming "yuri -futa" searches for page 190
# 91.238.105.48 - spamming "-rating:explicit hololive_englishs" searches
# 175.214.15.124 - spamming "<tag> order:score" searches, scraping html
# 2001:470:98f2::2 - Async PRAW
# 2600:3c01::f03c:92ff:fe0f:9014 - spamming "<character> rating:s" searches
# 2620:0:2820:2000:1da5:95ed:a412:27f0 - spamming "squidward*" and "among_us*" searches
resource "cloudflare_filter" "banned_ips" {
  zone_id    = cloudflare_zone.donmai_us.id
  expression = <<-EOS
    ip.src in {
      2.200.68.92
      34.226.218.10
      91.238.105.48
      175.214.15.124
      2001:470:98f2::2
      2600:3c01::f03c:92ff:fe0f:9014
      2620:0:2820:2000:1da5:95ed:a412:27f0
    }
  EOS
}

resource "cloudflare_firewall_rule" "suspect_logins" {
  zone_id     = cloudflare_zone.donmai_us.id
  filter_id   = cloudflare_filter.suspect_logins.id
  description = "Logins (blank referers and threats)"
  action      = "js_challenge"
  priority    = 750
}

# https://developers.cloudflare.com/firewall/known-issues-and-faq#how-can-i-use-the-threat-score-effectively
# cf.threat_score > 10 is medium security
resource "cloudflare_filter" "suspect_logins" {
  zone_id    = cloudflare_zone.donmai_us.id
  expression = <<-EOS
    (http.request.uri.path eq "/login" or http.request.uri.path eq "/session/new") and
    (not http.referer contains "donmai.us" or cf.threat_score gt 10)
  EOS
}

resource "cloudflare_firewall_rule" "block_danbooru_me" {
  zone_id     = cloudflare_zone.donmai_us.id
  filter_id   = cloudflare_filter.block_danbooru_me.id
  description = "Block Danbooru.me"
  action      = "js_challenge"
  priority    = 6000
}

resource "cloudflare_filter" "block_danbooru_me" {
  zone_id    = cloudflare_zone.donmai_us.id
  expression = <<-EOS
    ip.src in {
      66.245.205.0/24
      77.223.200.0/24
      79.139.81.0/24
      88.135.104.0/24
      88.135.106.0/24
      88.135.107.0/24
      109.94.145.0/24
      158.247.56.0/24
      193.108.52.0/24
      194.42.100.0/24
      195.189.187.0/24
    }
  EOS
}
