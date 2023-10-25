output "Issuer" {
  value = okta_auth_server.AuthServer.issuer
}
output "WellKnownEndpoint" {
  value = "${okta_auth_server.AuthServer.issuer}/.well-known/oauth-authorization-server"
}
output "Audiences" {
  value = okta_auth_server.AuthServer.audiences
}
output "CustomOAuthScope" {
  value = okta_auth_server_scope.AuthServerScope.name
}
output "CustomOIDCScope" {
  value = okta_auth_server_scope.EmployeeInfo.name
}
output "Description" {
  value = okta_auth_server.AuthServer.description
}
output "Name" {
  value = okta_auth_server.AuthServer.name
}