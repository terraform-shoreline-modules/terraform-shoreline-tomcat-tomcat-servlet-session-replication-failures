

#!/bin/bash

# Set variables

TIMEOUT=${NEW_SESSION_TIMEOUT_VALUE_IN_MINUTES}


# Edit context.xml file to increase session timeout

sed -i "s/<Manager/<Manager sessionTimeout=\"${TIMEOUT}\"/g" /etc/tomcat/conf/server.xml


# Restart Tomcat

systemctl restart tomcat