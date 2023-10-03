resource "shoreline_notebook" "tomcat_servlet_session_replication_failures" {
  name       = "tomcat_servlet_session_replication_failures"
  data       = file("${path.module}/data/tomcat_servlet_session_replication_failures.json")
  depends_on = [shoreline_action.invoke_update_session_timeout]
}

resource "shoreline_file" "update_session_timeout" {
  name             = "update_session_timeout"
  input_file       = "${path.module}/data/update_session_timeout.sh"
  md5              = filemd5("${path.module}/data/update_session_timeout.sh")
  description      = "If the issue persists, try increasing the session timeout value to allow more time for the session data to be replicated."
  destination_path = "/agent/scripts/update_session_timeout.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_session_timeout" {
  name        = "invoke_update_session_timeout"
  description = "If the issue persists, try increasing the session timeout value to allow more time for the session data to be replicated."
  command     = "`chmod +x /agent/scripts/update_session_timeout.sh && /agent/scripts/update_session_timeout.sh`"
  params      = ["NEW_SESSION_TIMEOUT_VALUE_IN_MINUTES"]
  file_deps   = ["update_session_timeout"]
  enabled     = true
  depends_on  = [shoreline_file.update_session_timeout]
}

