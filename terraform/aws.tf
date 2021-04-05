# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

# DKIM domain keys
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim
# https://console.aws.amazon.com/sesv2/home?region=us-east-1#/verified-identities/danbooru.donmai.us
resource "aws_ses_domain_dkim" "danbooru_donmai_us" {
  domain = "danbooru.donmai.us"
}

# Domain ownership verification key
#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity
# https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-domains.html
resource "aws_ses_domain_identity" "danbooru_donmai_us" {
  domain = "danbooru.donmai.us"
}
