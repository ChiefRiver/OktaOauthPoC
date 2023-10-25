#########################
# Data Sources for applications if already built an not it TF Code/Repo here
#########################

# data "okta_app" "ServiceA" {
#   label = "Service A"
# }
# data "okta_app" "ServiceB" {
#   label = "Service B"
# }
# data "okta_app" "ServiceC" {
#   label = "Service C"
# }

# data "okta_app" "Developers1" {
#   label = "Resource Developer App 1 "
# }

# data "okta_app" "Developers2" {
#   label = "Resource Developers App 2"
# }

module "AuthServer1" {
  source = ".//Modules/AuthServers"
  AuthServerName = "Authorizer for Resource 1"
  AuthServerDescription = "The Authorizer configured for Resource 1" 
  AuthServerAudiences = ["Resource1"]
  AuthServerAllowedClients = [okta_app_oauth.ServiceA.id,okta_app_oauth.ServiceB.id,okta_app_oauth.Developers1.id]
}

module "AuthServer2" {
  source = ".//Modules/AuthServers"
  AuthServerName = "Authorizer for Resource 2"
  AuthServerDescription = "The Authorizer configured for Resource 2" 
  AuthServerAudiences = ["Resource2"]
  AuthServerAllowedClients = [okta_app_oauth.ServiceB.id,okta_app_oauth.ServiceC.id,okta_app_oauth.Developers2.id]
}