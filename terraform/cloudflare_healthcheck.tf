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
}

resource "cloudflare_healthcheck" "cdn_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id

  name = "cdn-donmai-us"
  address = "cdn.donmai.us"
  type = "HTTPS"
  port = "443"
  path = "/original/d3/4e/d34e4cf0a437a5d65f8e82b7bcd02606.jpg?source=cloudflare-healthcheck"
  expected_codes = ["200"]

  header {
    header = "Cache-Control"
    values = ["no-cache"]
  }

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
}
