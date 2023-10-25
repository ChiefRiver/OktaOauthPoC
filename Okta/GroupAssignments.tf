resource "okta_app_group_assignments" "Assignment1" {
  app_id   = okta_app_oauth.Developers1.id
  group {
    id = okta_group.DeveloperGroup1.id
    priority = 1
  }
}

resource "okta_app_group_assignments" "Assignment2" {
  app_id   = okta_app_oauth.Developers2.id
  group {
    id = okta_group.DeveloperGroup2.id
    priority = 1
  }
}