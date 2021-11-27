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
  action      = "block"
  priority    = 500
}

# 1.117.171.171 - spamming full_body / solo searches
# 116.177.27.12 - same guy as above
# 2.200.68.92 - spamming "rating:explicit <tag>" searches for non-existent tags
# 8.210.47.67 - spamming "score:150.. order:id_desc" searches
# 34.90.245.177 - flooding malformed http requests (400 bad request)
# 34.226.218.10 - spamming "yuri -futa" searches for page 190
# 35.227.164.200 - excessive RSS feed requests
# 35.230.36.120 - excessive RSS feed requests
# 54.234.228.109 - excessive RSS feed requests
# 45.146.166.85 - vuln scanning
# 66.102.8.0/24 - https://danbooru-donmai-us.pornproxysite.com/
# 66.249.81.0/24 - https://danbooru-donmai-us.pornproxysite.com/
# 80.251.218.82 - high error rate (invalid api login names)
# 83.248.2.129 - Setsunator
# 188.148.116.39 - Setsunator
# 91.238.105.48 - spamming "-rating:explicit hololive_englishs" searches
# 107.72.178.93 - scraping /posts.json?page=aNNN too aggressively
# 139.162.207.44 - scraping "score:N order:id_desc" searches
# 136.244.116.19
# 172.105.55.247
# 192.46.232.197
# 175.214.15.124 - spamming "<tag> order:score" searches, scraping html
# 2a09:7c44::993 - spamming /posts?random=1 searches
## 2001:470:98f2::2 - Async PRAW (user:Midorina)
# 2600:3c01::f03c:92ff:fe0f:9014 - spamming "<character> rating:s" searches
# 2601:8a:400:8710:/64 - sending false dmca claims
# 2605:6400:20:64d:d15e:b6e1:862c:a2cd - spamming "upskirt order:random", "1girl heterochromia order:random", "yumemi_riamu score:>50 order:random", and "kagemori_michiru rating:safe order:random" searches
# 2620:0:2820:2000:1da5:95ed:a412:27f0 - spamming "squidward*" and "among_us*" searches
# 54.89.240.87 - spamming "yuri -futa" searches
# 54.226.45.112 - spamming "yuri -futa" searches
# 54.227.221.207 - spamming "yuri -futa" searches
# 155.138.224.79 - spamming "daughter order:random limit:1" searches at 10/s
# 217.178.210.115 - curl scraping
# 153.166.34.16 - curl scraping
# 138.124.186.137 - vuln crawling, submitting malformed iqdb hashes
# 220.136.68.65 - excessive scraping of /posts.json
# 20.38.173.55 - overaggressive scraping of /posts.json
# 52.173.139.234 - overaggressive scraping of /posts.json
# 3.208.86.85 - searching "86_-eightysix -rating:safe" five times per second for 24+ hours
#
# 40.122.49.223 - scraping with multiple IPs and faked user agent (Edg/88.0.705.63)
# 40.84.146.243
# 13.65.173.155
# 13.67.233.76
# 40.84.236.101
# 20.106.91.1
# 52.176.58.42
# 20.114.116.11
# 20.106.95.42
# 104.214.35.192
# 13.89.236.55
# 40.86.81.205
# 13.65.63.189
# 20.45.39.189
# 52.173.200.234
# 20.106.94.72
# 70.37.51.97
# 52.165.227.223
# 40.74.253.109
# 40.69.140.47
# 20.45.37.113
# 40.113.223.109
# 199.7.166.17
# 40.74.226.29
#
# 159.203.41.0 - perpetually scraping /tags.json
resource "cloudflare_filter" "banned_ips" {
  zone_id    = cloudflare_zone.donmai_us.id
  expression = <<-EOS
    ip.src in {
      1.117.171.171
      2.200.68.92
      8.210.47.67
      34.90.245.177
      34.226.218.10
      35.227.164.200
      35.230.36.120
      45.146.166.85
      54.234.228.109
      66.102.8.0/24
      66.249.81.0/24
      80.251.218.82
      83.248.2.129
      91.238.105.48
      107.72.178.93
      116.177.27.12 
      138.124.186.137
      139.162.207.44
      136.244.116.19
      153.166.34.16
      172.105.55.247
      175.214.15.124
      192.46.232.197
      188.148.116.39
      217.178.210.115
      2a09:7c44::993
      2600:3c01::f03c:92ff:fe0f:9014
      2601:8a:400:8710::/64
      2605:6400:20:64d:d15e:b6e1:862c:a2cd
      2620:0:2820:2000:1da5:95ed:a412:27f0
      54.89.240.87
      54.226.45.112
      54.227.221.207
      155.138.224.79
      220.136.68.65
      20.38.173.55
      20.106.78.137
      52.173.139.234
      3.208.86.85
      40.122.49.223
      40.84.146.243
      13.65.173.155
      13.67.233.76
      40.84.236.101
      20.106.91.1
      52.176.58.42
      20.114.116.11
      20.106.95.42
      104.214.35.192
      13.89.236.55
      40.86.81.205
      13.65.63.189
      20.45.39.189
      52.173.200.234
      20.106.94.72
      70.37.51.97
      52.165.227.223
      40.74.253.109
      40.69.140.47
      20.45.37.113
      40.113.223.109
      199.7.166.17
      40.74.226.29
      159.203.41.0
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

resource "cloudflare_firewall_rule" "dmail_spam" {
  zone_id     = cloudflare_zone.donmai_us.id
  filter_id   = cloudflare_filter.dmail_spam.id
  description = "DMail spam (/dmails/new)"
  action      = "challenge"
  priority    = 760
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

resource "cloudflare_filter" "dmail_spam" {
  zone_id    = cloudflare_zone.donmai_us.id
  expression = <<-EOS
    (http.request.uri.path eq "/dmails/new" or http.request.uri.path eq "/users/new") and (http.referer contains "forum_topics")
  EOS
}

resource "cloudflare_firewall_rule" "block_danbooru_me" {
  zone_id     = cloudflare_zone.donmai_us.id
  filter_id   = cloudflare_filter.block_danbooru_me.id
  description = "Block Danbooru.me"
  action      = "block"
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
