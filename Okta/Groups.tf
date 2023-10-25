##################
# Data source for existing users
##################
# data "okta_user" "User1" {
#   user_id = "00ie25e485KJm29482M"
# }

# data "okta_user" "User2" {
#   user_id = "00ie258fieLk32Kng3f"
# }


###############################
# Dev Group 1 and assignemnt
###############################

resource "okta_group" "DeveloperGroup1" {
  name        = "Developer Group 1"
  description = "Development Group 1"
}

resource "okta_group_memberships" "DeveloperGroup1" {
  group_id = okta_group.DeveloperGroup1.id
  users = [
    # data.okta_user.User1.id,
    okta_user.User1.id
  ]
}

###############################
# Dev Group 2 and assignemnt
###############################

resource "okta_group" "DeveloperGroup2" {
  name        = "Developer Group 2"
  description = "Development Group 2"
}

resource "okta_group_memberships" "DeveloperGroup2" {
  group_id = okta_group.DeveloperGroup2.id
  users = [
    # data.okta_user.User2.id,
    okta_user.User2.id
  ]
}