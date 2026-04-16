# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record
# https://support.cloudflare.com/hc/en-us/articles/360019093151-Managing-DNS-records-in-Cloudflare

resource "cloudflare_dns_record" "danbooru_donmai_us" {
  count   = 2
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
  content = [
    local.servers.gura.ipv4,
    local.servers.ame.ipv4,
    # local.servers.ina.ipv4,
  ][count.index]
}

resource "cloudflare_dns_record" "isshiki_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "isshiki.donmai.us"
  content = local.servers.isshiki.ipv4
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "betabooru_donmai_us" {
  count   = 2
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "betabooru.donmai.us"
  proxied = true
  ttl     = 1
  content = [
    local.servers.gura.ipv4,
    local.servers.ame.ipv4,
    # local.servers.ina.ipv4,
  ][count.index]
}

resource "cloudflare_dns_record" "autotagger_donmai_us" {
  count   = 2
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "autotagger.donmai.us"
  proxied = true
  ttl     = 1
  content = [
    local.servers.gura.ipv4,
    local.servers.ame.ipv4,
    # local.servers.ina.ipv4,
  ][count.index]
}

resource "cloudflare_dns_record" "signoz_donmai_us" {
  count   = 3
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "signoz.donmai.us"
  proxied = true
  ttl     = 1
  content = [
    local.servers.gura.ipv4,
    local.servers.ame.ipv4,
    local.servers.ina.ipv4,
  ][count.index]
}

resource "cloudflare_dns_record" "mail_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "mail.donmai.us"
  ttl     = 1
  content = local.servers.mori.ipv4
}

resource "cloudflare_dns_record" "naoko_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "naoko.donmai.us"
  content = local.servers.naoko.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "oumae_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "oumae.donmai.us"
  content = local.servers.oumae.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "gura_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "gura.donmai.us"
  content = local.servers.gura.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "ame_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ame.donmai.us"
  content = local.servers.ame.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "ina_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ina.donmai.us"
  content = local.servers.ina.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "mori_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "mori.donmai.us"
  content = local.servers.mori.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "irys_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "irys.donmai.us"
  content = local.servers.irys.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "ssh_isshiki_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ssh.isshiki.donmai.us"
  content = local.servers.isshiki.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "haachama_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "haachama.donmai.us"
  content = local.servers.haachama.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "node1_haachama_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "node1.haachama.donmai.us"
  content = local.servers.node1_haachama.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "node2_haachama_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "node2.haachama.donmai.us"
  content = local.servers.node2_haachama.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "node3_haachama_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "node3.haachama.donmai.us"
  content = local.servers.node3_haachama.ipv4
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "cdn_donmai_us" {
  count   = 1
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "cdn.donmai.us"
  proxied = true
  ttl     = 1
  content = [
    local.servers.bijou.ipv4,
  ][count.index]
}

resource "cloudflare_dns_record" "cdn0_donmai_us" {
  count   = 1
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "cdn0.donmai.us"
  proxied = true
  ttl     = 1
  content = local.servers.bijou.ipv4
}

resource "cloudflare_dns_record" "cdn1_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "cdn1.donmai.us"
  proxied = true
  ttl     = 1
  content = local.servers.irys.ipv4
}

#
# CNAME
#

resource "cloudflare_dns_record" "safebooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "safebooru.donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "testbooru_donmai_us" {
  count   = 3
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "testbooru.donmai.us"
  proxied = true
  ttl     = 1
  content = [
    local.servers.node1_haachama.ipv4,
    local.servers.node2_haachama.ipv4,
    local.servers.node3_haachama.ipv4,
  ][count.index]
}

resource "cloudflare_dns_record" "testbooru_cdn_donmai_us" {
  count   = 3
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "testbooru-cdn.donmai.us"
  proxied = true
  ttl     = 1
  content = [
    local.servers.node1_haachama.ipv4,
    local.servers.node2_haachama.ipv4,
    local.servers.node3_haachama.ipv4,
  ][count.index]
}

#
# CNAME redirects to danbooru.donmai.us
#

resource "cloudflare_dns_record" "donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "www_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "www.donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "www_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "www.danbooru.donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "sonohara_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "sonohara.donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "hijiribe_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "hijiribe.donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "saitou_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "saitou.donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "shima_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "shima.donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "kagamihara_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "kagamihara.donmai.us"
  content = "danbooru.donmai.us"
  proxied = true
  ttl     = 1
}

#
# CNAME redirects to cdn.donmai.us
#

resource "cloudflare_dns_record" "raikou1_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "raikou1.donmai.us"
  content = "cdn.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "raikou2_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "raikou2.donmai.us"
  content = "cdn.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "raikou3_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "raikou3.donmai.us"
  content = "cdn.donmai.us"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "raikou4_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "raikou4.donmai.us"
  content = "cdn.donmai.us"
  proxied = true
  ttl     = 1
}

#
# MX records
#

resource "cloudflare_dns_record" "mx_donmai_us" {
  zone_id  = cloudflare_zone.donmai_us.id
  type     = "MX"
  name     = "danbooru.donmai.us"
  content  = "mail.donmai.us"
  priority = 0
  ttl      = 1
}

#
# Other records
#

# Sender Policy Framework (SPF) lets domain owners tell email providers which
# servers are allowed to send email from their domains.
#
# https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-authentication-spf.html
resource "cloudflare_dns_record" "spf_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "danbooru.donmai.us"
  content = "v=spf1 mx include:amazonses.com ~all"
  ttl     = 1
}

resource "cloudflare_dns_record" "spf_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "donmai.us"
  content = "v=spf1 -all"
  ttl     = 1
}

# Domain-based Message Authentication, Reporting and Conformance (DMARC) is an
# email authentication protocol that uses Sender Policy Framework (SPF) and
# DomainKeys Identified Mail (DKIM) to detect email spoofing.
#
# https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-authentication-dmarc.html
resource "cloudflare_dns_record" "dmarc_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "_dmarc.donmai.us"
  content = "v=DMARC1; p=none; sp=none; pct=100; fo=1; rua=mailto:dmarc@danbooru.donmai.us; ruf=mailto:dmarc@danbooru.donmai.us;"
  ttl     = 1
}

# Sparkpost domain verification
resource "cloudflare_dns_record" "scph1022_domainkey_danbooru_donmai_us" {
  count   = 1
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "scph1022._domainkey.danbooru.donmai.us"
  # p is the DKIM public key used by recipients to verify signed emails (not secret)
  content = "v=DKIM1; k=rsa; h=sha256; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyiVpbSNKJLwnJ/Z9ak1QJp27LwCYtoRDjDEYxfEJf6ssDlt7oiLA0xYyfMwmCGR0wnQ58BnCvjE9fwoJgkshVjXgaWLXcbAoHl4ThyeqtiQ3Hk0bqQSth8drxgPihTDxQeDjBMR16KJeQMa2CPad8Hw9eC2I9xRIU10jPTkEQPwIDAQAB"
  ttl     = 1
}

resource "cloudflare_dns_record" "bounce_danbooru_donmai_us" {
  count   = 1
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "bounce.danbooru.donmai.us"
  content = "sparkpostmail.com"
  ttl     = 1
}

# Verify domain ownership with Github to get a verified badge on https://github.com/danbooru.
# https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/verifying-your-organizations-domain
resource "cloudflare_dns_record" "github_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "_github-challenge-danbooru.danbooru.donmai.us"
  content = "f5bba4a1e0"
  ttl     = 1
}

# Verify domain ownership for Google search console.
# https://www.google.com/webmasters/verification/home
# https://developers.google.com/site-verification
resource "cloudflare_dns_record" "google_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "donmai.us"
  content = "google-site-verification=VNLiS2VLxjYQKbuupFjE_Z55bGaJmQlXCNYTR89VvyM"
  ttl     = 1
}

# https://developers.facebook.com/docs/sharing/domain-verification/
resource "cloudflare_dns_record" "facebook_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "danbooru.donmai.us"
  content = "facebook-domain-verification=dd7v7l0a4k4x01mzzmjf4duj2eif04"
  ttl     = 1
}

resource "cloudflare_dns_record" "facebook_domain_verification_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "donmai.us"
  content = "facebook-domain-verification=7akblgtmzroi48r5lyrqddvzojtooz"
  ttl     = 1
}

# Verify domain ownership for Yandex search console.
# https://webmaster.yandex.com/site/https:danbooru.donmai.us:443/settings/access/
resource "cloudflare_dns_record" "yandex_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "danbooru.donmai.us"
  content = "yandex-verification: fa456bda52099f32"
  ttl     = 1
}

resource "cloudflare_dns_record" "bing_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "1d230d6ffbc11b54e957cf0e3dc0ad6c.donmai.us"
  content = "verify.bing.com"
  ttl     = 1
}
