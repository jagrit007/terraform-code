locals {
  project_name        = var.project_name
  key_name            = "${var.project_name}-default-key"
  security_group_name = "${var.project_name}-web-app"
}