#####################
#  Auth server Basic Build
#####################
resource "okta_auth_server" "AuthServer" {
  description = var.AuthServerDescription
  name        = var.AuthServerName
  audiences   = var.AuthServerAudiences
  issuer_mode = "DYNAMIC"
}

resource "okta_auth_server_scope" "AuthServerScope" {
  auth_server_id = okta_auth_server.AuthServer.id
  consent        = "IMPLICIT"
  description    = "Custom Scope"
  name           = "access"
  display_name   = "Custom Scope to allow access for Credential Flow"
  metadata_publish = "NO_CLIENTS"
}

resource "okta_auth_server_policy" "AuthServerPolicy" {
  auth_server_id   = okta_auth_server.AuthServer.id
  status           = "ACTIVE"
  name             = "Allowed Clients"
  description      = "Clients allowed to interact with the authorization server"
  priority         = 1
  client_whitelist = var.AuthServerAllowedClients
}

resource "okta_auth_server_policy_rule" "AuthServerRule" {
  auth_server_id       = okta_auth_server.AuthServer.id
  policy_id            = okta_auth_server_policy.AuthServerPolicy.id
  status               = "ACTIVE"
  name                 = "Allowed Grant/Scopes"
  priority             = 1
  group_whitelist      = ["EVERYONE"]
  grant_type_whitelist = ["client_credentials","authorization_code"]
  scope_whitelist      = ["*"]
  access_token_lifetime_minutes = 5
}

#################
## Custom Scope
#################
resource "okta_auth_server_scope" "EmployeeInfo" {
  auth_server_id   = okta_auth_server.AuthServer.id
  metadata_publish = "ALL_CLIENTS"
  name             = "EmployeeInfo"
  consent          = "IMPLICIT"
}

#################
## Custom Claims
#################
resource "okta_auth_server_claim" "Department" {
  auth_server_id = okta_auth_server.AuthServer.id
  name           = "Department"
  value          = "user.department"
  claim_type     = "RESOURCE"
  scopes         = [okta_auth_server_scope.EmployeeInfo.name]
}

resource "okta_auth_server_claim" "EmployeeNum" {
  auth_server_id = okta_auth_server.AuthServer.id
  name           = "EmployeeNumber"
  value          = "user.employeeNumber"
  claim_type     = "RESOURCE"
  scopes         = [okta_auth_server_scope.EmployeeInfo.name]
}