resource "okta_user" "User1" {
  first_name      = "User"
  last_name       = "One"
  employee_number  = "11111"
  department      = "FrontEndDeveloper"
  login           = "User1@test.com"
  email           = "User1@test.com"
  password        = "User$One!"
}

resource "okta_user" "User2" {
  first_name      = "User"
  last_name       = "Two"
  employee_number  = "22222"
  department      = "BackEndDeveloper"
  login           = "User2@test.com"
  email           = "User2@test.com"
  password        = "User$Two!"
}