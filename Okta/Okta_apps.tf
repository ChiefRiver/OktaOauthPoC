#######################
# Developer OIDC App
#######################
resource "okta_app_oauth" "Developers1" {
  label                      = "Resource Developers 1"
  type                       = "web"
  grant_types                = ["authorization_code"]
  redirect_uris              = ["http://localhost:8080/authorization-code/callback"]
  response_types             = ["code"]
  consent_method             = "REQUIRED"
  //implicit_assignment        = true
  post_logout_redirect_uris  = ["http://localhost:8080"]
  issuer_mode                = "DYNAMIC"
  lifecycle {
     ignore_changes = [groups]
  }
}

resource "okta_app_oauth" "Developers2" {
  label                      = "Resource Developers 2"
  type                       = "web"
  grant_types                = ["authorization_code"]
  redirect_uris              = ["http://localhost:8080/authorization-code/callback"]
  response_types             = ["code"]
  consent_method             = "REQUIRED"
  //implicit_assignment        = true
  post_logout_redirect_uris  = ["http://localhost:8080"]
  issuer_mode                = "DYNAMIC"
  lifecycle {
     ignore_changes = [groups]
  }
}

#######################
# Developer OIDC profile mappings
#######################

resource "okta_app_user_schema_property" "EmployeeNumUser1" {
  app_id      = okta_app_oauth.Developers1.id
  index       = "employeeNumber"
  title       = "employeeNumber"
  type        = "string"
  description = "Emplyee ID Name"
  scope       = "SELF"
}
resource "okta_app_user_schema_property" "DeparmentUser1" {
  app_id      = okta_app_oauth.Developers1.id
  index       = "department"
  title       = "department"
  type        = "string"
  description = "Emplyee department"
  scope       = "SELF"
}
resource "okta_app_user_schema_property" "EmployeeNumUser2" {
  app_id      = okta_app_oauth.Developers2.id
  index       = "employeeNumber"
  title       = "employeeNumber"
  type        = "string"
  description = "Emplyee ID Name"
  scope       = "SELF"
}
resource "okta_app_user_schema_property" "DeparmentUser2" {
  app_id      = okta_app_oauth.Developers2.id
  index       = "department"
  title       = "department"
  type        = "string"
  description = "Emplyee department"
  scope       = "SELF"
}




#######################
# Service Client Apps
#######################
resource "okta_app_oauth" "ServiceA" {
  label          = "Service A"
  type           = "service"
  response_types = ["token"]
  grant_types    = ["client_credentials"]
}

resource "okta_app_oauth" "ServiceB" {
  label          = "Service B"
  type           = "service"
  response_types = ["token"]
  grant_types    = ["client_credentials"]
}

resource "okta_app_oauth" "ServiceC" {
  label          = "Service C"
  type           = "service"
  response_types = ["token"]
  grant_types    = ["client_credentials"]
}

