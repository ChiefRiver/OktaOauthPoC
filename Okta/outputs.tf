output "AuthServer_1" {
  value = module.AuthServer1
}

output "AuthServer_2" {
  value = module.AuthServer2
}

output "Service_A_ClientID" {
  value = okta_app_oauth.ServiceA.client_id
}
output "Service_A_Secret" {
  value = okta_app_oauth.ServiceA.client_secret
  sensitive = true
}

output "Service_B_ClientID" {
  value = okta_app_oauth.ServiceB.client_id
}
output "Service_B_Secret" {
  value = okta_app_oauth.ServiceB.client_secret
  sensitive = true
}

output "Service_C_ClientID" {
  value = okta_app_oauth.ServiceC.client_id
}
output "Service_C_Secret" {
  value = okta_app_oauth.ServiceC.client_secret
  sensitive = true
}

output "DevGroup_1_ClientID" {
  value = okta_app_oauth.Developers1.client_id
}
output "DevGroup_1_Client_Secret" {
  value = okta_app_oauth.Developers1.client_secret
  sensitive = true
}
output "DevGroup_1_CallBack" {
  value = okta_app_oauth.Developers1.redirect_uris
}

output "DevGroup_2_ClientID" {
  value = okta_app_oauth.Developers2.client_id
}
output "DevGroup_2_Secret" {
  value = okta_app_oauth.Developers2.client_secret
  sensitive = true
}
output "DevGroup_2_CallBack" {
  value = okta_app_oauth.Developers2.redirect_uris
}

output "User1" {
  value = okta_user.User1.login
}
output "User1_Password" {
  value = okta_user.User1.password
  sensitive = true
}

output "User2" {
  value = okta_user.User2.login
}
output "User2_Password" {
  value = okta_user.User2.password
  sensitive = true
}