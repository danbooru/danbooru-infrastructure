resource "cloudflare_healthcheck" "danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id

  name = "danbooru-donmai-us"
  address = "danbooru.donmai.us"
  type = "HTTPS"
  port = "443"
  path = "/"
  expected_codes = ["200"]

  header {
    header = "Host"
    values = ["danbooru.donmai.us"]
  }

  # https://api.cloudflare.com/#load-balancer-pools-update-pool
  check_regions = [
    "ENAM", # East North America
    "WEU",  # West EU
    "SEAS", # South East Asia
  ]

  interval = 60
  timeout = 5
  retries = 2
  consecutive_fails = 2
  consecutive_successes = 2

  notification_suspended = false
  notification_email_addresses = [
    "webmaster@danbooru.donmai.us"
  ]
}

resource "cloudflare_healthcheck" "cdn_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id

  name = "cdn-donmai-us"
  address = "cdn.donmai.us"
  type = "HTTPS"
  port = "443"
  path = "/robots.txt"
  expected_codes = ["200"]

  header {
    header = "Host"
    values = ["cdn.donmai.us"]
  }

  # https://api.cloudflare.com/#load-balancer-pools-update-pool
  check_regions = [
    "ENAM", # East North America
    "WEU",  # West EU
    "SEAS", # South East Asia
  ]

  interval = 60
  timeout = 5
  retries = 2
  consecutive_fails = 2
  consecutive_successes = 2

  notification_suspended = false
  notification_email_addresses = [
    "webmaster@danbooru.donmai.us"
  ]
}
