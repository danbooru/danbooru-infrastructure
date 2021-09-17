# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record
# https://support.cloudflare.com/hc/en-us/articles/360019093151-Managing-DNS-records-in-Cloudflare

resource "cloudflare_record" "danbooru_donmai_us" {
  count   = 6
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "danbooru"
  value = [
    local.servers.saitou.ipv4,
    local.servers.kagamihara.ipv4,
    local.servers.shima.ipv4,
    local.servers.gura.ipv4,
    local.servers.ame.ipv4,
    local.servers.ina.ipv4,
  ][count.index]
  proxied = true
}

resource "cloudflare_record" "danbooru_k8s_donmai_us" {
  count   = 3
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "danbooru-k8s"
  value = [
    local.servers.gura.ipv4,
    local.servers.ame.ipv4,
    local.servers.ina.ipv4,
  ][count.index]
  proxied = true
}

resource "cloudflare_record" "inuyama_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "inuyama"
  value   = local.servers.inuyama.ipv4
  proxied = false
}

resource "cloudflare_record" "isshiki_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "isshiki"
  value   = local.servers.isshiki.ipv4
  proxied = true
}

resource "cloudflare_record" "kagamihara_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "kagamihara"
  value   = local.servers.kagamihara.ipv4
  proxied = true
}

resource "cloudflare_record" "kinako_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "kinako"
  value   = local.servers.kinako.ipv4
  proxied = false
}

resource "cloudflare_record" "korone_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "korone"
  value   = local.servers.korone.ipv4
  proxied = true
}

resource "cloudflare_record" "betabooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "betabooru"
  value   = local.servers.korone.ipv4
  proxied = true
}

resource "cloudflare_record" "mail_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "mail"
  value   = local.servers.oogaki.ipv4
}

resource "cloudflare_record" "naoko_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "naoko"
  value   = local.servers.naoko.ipv4
  proxied = false
}

resource "cloudflare_record" "oogaki_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "oogaki"
  value   = local.servers.oogaki.ipv4
  proxied = false
}

resource "cloudflare_record" "oumae_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "oumae"
  value   = local.servers.oumae.ipv4
  proxied = false
}

resource "cloudflare_record" "saitou_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "saitou"
  value   = local.servers.saitou.ipv4
  proxied = true
}

resource "cloudflare_record" "shima_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "shima"
  value   = local.servers.shima.ipv4
  proxied = true
}

resource "cloudflare_record" "gura_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "gura"
  value   = local.servers.gura.ipv4
  proxied = false
}

resource "cloudflare_record" "ame_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ame"
  value   = local.servers.ame.ipv4
  proxied = false
}

resource "cloudflare_record" "ina_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ina"
  value   = local.servers.ina.ipv4
  proxied = false
}

resource "cloudflare_record" "yukinoshita_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "yukinoshita"
  value   = local.servers.yukinoshita.ipv4
  proxied = false
}

resource "cloudflare_record" "ssh_isshiki_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ssh.isshiki"
  value   = local.servers.isshiki.ipv4
  proxied = false
}

resource "cloudflare_record" "ssh_kagamihara_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ssh.kagamihara"
  value   = local.servers.kagamihara.ipv4
  proxied = false
}

resource "cloudflare_record" "ssh_kinako_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ssh.kinako"
  value   = local.servers.kinako.ipv4
  proxied = false
}

resource "cloudflare_record" "ssh_haachama_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ssh.haachama"
  value   = local.servers.haachama.ipv4
  proxied = false
}

resource "cloudflare_record" "ssh_korone_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ssh.korone"
  value   = local.servers.korone.ipv4
  proxied = false
}

resource "cloudflare_record" "ssh_saitou_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ssh.saitou"
  value   = local.servers.saitou.ipv4
  proxied = false
}

resource "cloudflare_record" "ssh_shima_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "ssh.shima"
  value   = local.servers.shima.ipv4
  proxied = false
}

resource "cloudflare_record" "cdn_donmai_us" {
  count   = 2
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "cdn"
  proxied = true
  value = [
    local.servers.kinako.ipv4,
    local.servers.korone.ipv4,
  ][count.index]
}

resource "cloudflare_record" "cdn_beta_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "A"
  name    = "cdn-beta"
  value   = local.servers.korone.ipv4
  proxied = true
}

#
# CNAME
#

resource "cloudflare_record" "safebooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "safebooru"
  value   = "danbooru.donmai.us"
  proxied = true
}

resource "cloudflare_record" "testbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "testbooru"
  value   = "oogaki.donmai.us"
  proxied = true
}

resource "cloudflare_record" "b2_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "b2"
  value   = "f000.backblazeb2.com"
  proxied = true
}

#
# CNAME redirects to danbooru.donmai.us
#

resource "cloudflare_record" "donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "donmai.us"
  value   = "danbooru.donmai.us"
  proxied = true
}

resource "cloudflare_record" "www_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "www"
  value   = "danbooru.donmai.us"
  proxied = true
}

resource "cloudflare_record" "sonohara_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "sonohara"
  value   = "danbooru.donmai.us"
  proxied = true
}

resource "cloudflare_record" "hijiribe_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "hijiribe"
  value   = "danbooru.donmai.us"
  proxied = true
}

#
# CNAME redirects to cdn.donmai.us
#

resource "cloudflare_record" "raikou1_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "raikou1"
  value   = "cdn.donmai.us"
  proxied = true
}

resource "cloudflare_record" "raikou2_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "raikou2"
  value   = "cdn.donmai.us"
  proxied = true
}

resource "cloudflare_record" "raikou3_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "raikou3"
  value   = "cdn.donmai.us"
  proxied = true
}

resource "cloudflare_record" "raikou4_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "raikou4"
  value   = "cdn.donmai.us"
  proxied = true
}

#
# MX records
#

resource "cloudflare_record" "mx_donmai_us" {
  zone_id  = cloudflare_zone.donmai_us.id
  type     = "MX"
  name     = "danbooru"
  value    = "mail.donmai.us"
  priority = 0
}

#
# Other records
#

# DKIM records for AWS SES
# https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail
resource "cloudflare_record" "dkim_danbooru_donmai_us" {
  count   = 3
  zone_id = cloudflare_zone.donmai_us.id
  type    = "CNAME"
  name    = "${element(aws_ses_domain_dkim.danbooru_donmai_us.dkim_tokens, count.index)}._domainkey.danbooru"
  value   = "${element(aws_ses_domain_dkim.danbooru_donmai_us.dkim_tokens, count.index)}.dkim.amazonses.com"
}

# Sender Policy Framework (SPF) lets domain owners tell email providers which
# servers are allowed to send email from their domains.
#
# https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-authentication-spf.html
resource "cloudflare_record" "spf_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "danbooru"
  value   = "v=spf1 mx include:amazonses.com ~all"
}

resource "cloudflare_record" "spf_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "donmai.us"
  value   = "v=spf1 -all"
}

# Domain-based Message Authentication, Reporting and Conformance (DMARC) is an
# email authentication protocol that uses Sender Policy Framework (SPF) and
# DomainKeys Identified Mail (DKIM) to detect email spoofing.
#
# https://docs.aws.amazon.com/ses/latest/DeveloperGuide/send-email-authentication-dmarc.html
resource "cloudflare_record" "dmarc_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "_dmarc"
  value   = "v=DMARC1; p=none; sp=none; pct=100; fo=1; rua=mailto:dmarc@danbooru.donmai.us; ruf=mailto:dmarc@danbooru.donmai.us;"
}

# Verify domain ownership for AWS SES
resource "cloudflare_record" "aws_ses_verification_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "_amazonses.danbooru"
  value   = aws_ses_domain_identity.danbooru_donmai_us.verification_token
}


# Verify domain ownership with Github to get a verified badge on https://github.com/danbooru.
# https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/verifying-your-organizations-domain
resource "cloudflare_record" "github_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "_github-challenge-danbooru.danbooru"
  value   = "f5bba4a1e0"
}

# Verify domain ownership for Google search console.
# https://www.google.com/webmasters/verification/home
# https://developers.google.com/site-verification
resource "cloudflare_record" "google_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "donmai.us"
  value   = "google-site-verification=VNLiS2VLxjYQKbuupFjE_Z55bGaJmQlXCNYTR89VvyM"
}

# https://developers.facebook.com/docs/sharing/domain-verification/
resource "cloudflare_record" "facebook_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "donmai.us"
  value   = "facebook-domain-verification=gck3lrvxm06ovoody2eomfx4m1orgz"
}

# Verify domain ownership for Yandex search console.
# https://webmaster.yandex.com/site/https:danbooru.donmai.us:443/settings/access/
resource "cloudflare_record" "yandex_domain_verification_danbooru_donmai_us" {
  zone_id = cloudflare_zone.donmai_us.id
  type    = "TXT"
  name    = "danbooru"
  value   = "yandex-verification: fa456bda52099f32"
}
