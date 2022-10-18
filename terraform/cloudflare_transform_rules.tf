# https://developers.cloudflare.com/rules/transform/request-header-modification/
# https://developers.cloudflare.com/rules/transform/request-header-modification/reference/fields-functions/
# https://developers.cloudflare.com/rules/transform/request-header-modification/create-api/
resource "cloudflare_ruleset" "donmai_us_add_http_headers" {
  zone_id = cloudflare_zone.donmai_us.id
  name  = "Add HTTP Headers"
  kind  = "zone"
  phase = "http_request_late_transform"

  rules {
    description = "Add HTTP Headers"
    enabled    = true
    action     = "rewrite"
    expression = "true"

    action_parameters {
      headers {
        name       = "X-Cloudflare-Bot"
        operation  = "set"
        expression = "to_string(cf.client.bot)"
      }

      headers {
        name       = "X-Cloudflare-Threat-Score"
        operation  = "set"
        expression = "to_string(cf.threat_score)"
      }

      headers {
        name       = "X-HTTP-Version"
        operation  = "set"
        expression = "http.request.version"
      }

      headers {
        name       = "X-IP-ASN"
        operation  = "set"
        expression = "to_string(ip.geoip.asnum)"
      }

      headers {
        name       = "X-IP-City"
        operation  = "set"
        expression = "ip.src.city"
      }

      headers {
        name       = "X-IP-Continent"
        operation  = "set"
        expression = "ip.geoip.continent"
      }

      headers {
        name       = "X-IP-Country"
        operation  = "set"
        expression = "ip.src.country"
      }

      headers {
        name       = "X-Request-Id"
        operation  = "set"
        expression = "cf.ray_id"
      }

      headers {
        name       = "X-Request-Start"
        operation  = "set"
        expression = "concat(to_string(http.request.timestamp.sec), \".\", to_string(http.request.timestamp.msec))"
      }
    }
  }
}
