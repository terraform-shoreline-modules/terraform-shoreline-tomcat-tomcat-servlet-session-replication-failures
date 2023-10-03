
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Tomcat Servlet Session Replication Failures.
---

Tomcat Servlet Session Replication Failures occur when a Tomcat server fails to replicate session data between instances. This can result in users losing their session data or being redirected to a different instance, causing disruption to the application's functionality.

### Parameters
```shell
export INSTANCE_NUMBER="PLACEHOLDER"

export TOMCAT_REPLICATION_PORT="PLACEHOLDER"

export NEW_SESSION_TIMEOUT_VALUE_IN_MINUTES="PLACEHOLDER"

```

## Debug

### Check if all Tomcat instances are up and running
```shell
systemctl status tomcat${INSTANCE_NUMBER}.service
```

### Check if session replication is enabled in server.xml
```shell
grep -i "Cluster" /etc/tomcat${INSTANCE_NUMBER}/server.xml
```

### Check if the session data is being replicated between instances
```shell
cat /var/log/tomcat${INSTANCE_NUMBER}/localhost.${INSTANCE_NUMBER}.log | grep -i "Replication"
```

### Check if the session data is being stored correctly in the shared directory
```shell
ls -l /var/lib/tomcat${INSTANCE_NUMBER}/work/localhost/SESSIONS.ser
```

### Check if the firewall is blocking the replication traffic
```shell
iptables -L -n | grep -i "ACCEPT" | grep -i "dport ${TOMCAT_REPLICATION_PORT}"
```

### Check if there are any errors or exceptions in the logs related to session replication
```shell
cat /var/log/tomcat${INSTANCE_NUMBER}/catalina.out | grep -i "error\|exception"
```

## Repair

### If the issue persists, try increasing the session timeout value to allow more time for the session data to be replicated.
```shell


#!/bin/bash

# Set variables

TIMEOUT=${NEW_SESSION_TIMEOUT_VALUE_IN_MINUTES}


# Edit context.xml file to increase session timeout

sed -i "s/<Manager/<Manager sessionTimeout=\"${TIMEOUT}\"/g" /etc/tomcat/conf/server.xml


# Restart Tomcat

systemctl restart tomcat


```