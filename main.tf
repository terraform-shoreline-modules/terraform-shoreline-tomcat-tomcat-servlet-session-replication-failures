terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "tomcat_servlet_session_replication_failures" {
  source    = "./modules/tomcat_servlet_session_replication_failures"

  providers = {
    shoreline = shoreline
  }
}