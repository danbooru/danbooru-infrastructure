## About

[Terraform](https://www.terraform.io/) configuration for Danbooru.

## Usage

Install Terraform:

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

Initialize Terraform and install Terraform providers:

```
terraform init
```

Configure your API keys (see variables.tf for docs):

```
cp terraform.tfvars.example terraform.tfvars
vi terraform.tfvars
```

Preview changes:

```
terraform plan
```

Apply changes:

```
terraform apply
```

## External links

* https://www.terraform.io/
* https://learn.hashicorp.com/terraform
* https://learn.hashicorp.com/tutorials/terraform/install-cli
* https://www.linode.com/docs/guides/beginners-guide-to-terraform/
* https://developers.cloudflare.com/terraform/tutorial/hello-world/
* https://developers.cloudflare.com/terraform/advanced-topics/importing-cloudflare-resources
* https://github.com/cloudflare/cf-terraforming
