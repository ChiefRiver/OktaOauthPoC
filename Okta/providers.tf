terraform {
  required_providers {
    okta = {
      source = "okta/okta"
      version = "~> 3.36"
    }
  }
}

# Configure the Okta Provider
provider "okta" {
  # set your env vars as below before utilzing this provider
  # export OKTA_ORG_NAME="dev-90134837"
  # export OKTA_BASE_URL="okta.com"
  # export OKTA_API_TOKEN="00edIeAmDTK12R1-P5v4u-orP0BAbA7nkE-wRx5gof"
}