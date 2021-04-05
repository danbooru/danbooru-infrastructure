# Set the variables in this file in terraform.tfvars. See
# terraform.tfvars.example for an example.

#
# Amazon AWS
#

# https://console.aws.amazon.com/iam/home#/users
#
# Required permissions:
#
# * AmazonSESReadOnlyAccess (for reading DKIM keys from SES)

variable "aws_access_key" {}
variable "aws_secret_key" {}

#
# Cloudflare
#

# https://dash.cloudflare.com/profile/api-tokens
#
# Required permissions:
#
# * DNS:Edit
# * Page Rules:Edit
# * Firewall Services:Edit
# * Zone Settings:Edit

variable "cloudflare_api_token" {}

#
# Hetzner
#

# Create a "Webservice/app user" at https://robot.your-server.de/preferences/index
variable "hetzner_username" {}
variable "hetzner_password" {}

#
# Linode
#

# https://www.linode.com/docs/api/#section/Personal-Access-Token
variable "linode_token" {}

#
# OVH
#

# * Go to https://api.us.ovhcloud.com/createApp/
# * Create application and save application_key and application_secret
# * Get consumer_key by doing this API call:
#
#   curl \
#    -X POST \
#    -H "X-Ovh-Application: $OVH_APPLICATION_KEY" \
#    -H "X-Ovh-Timestamp: $(date +%s)" \
#    -H "Content-Type: application/json" \
#    https://api.us.ovhcloud.com/1.0/auth/credential \
#    -d '{
#     "accessRules": [
#       { "method": "DELETE", "path": "/*" },
#       { "method": "GET", "path": "/*" },
#       { "method": "POST", "path": "/*" },
#       { "method": "PUT", "path": "/*" }
#     ]
#   }'

variable "ovh_application_key" {}
variable "ovh_application_secret" {}
variable "ovh_consumer_key" {}

#
# Scaleway Dedibox (online.net)
#

# Get your API token at https://console.online.net/en/api/access
variable "scaleway_dedibox_api_token" {}

#
# Server configuration
#

# A map of server names to server IDs. The server IDs are the IDs used by the
# hosting provider's API, which varies by provider (usually a hostname, or an
# IP address, or an ID number).
variable "server_ids" {
  type = map(any)
}
