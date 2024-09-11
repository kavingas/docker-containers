#!/bin/bash

echo "Performing custom shutdown tasks..."
# Perform custom cleanup tasks here

# Stop AEM gracefully
curl -u admin:admin -X POST http://localhost:4502/system/console/jmx/com.adobe.granite:type=ScriptMBean?action=shutdown
curl -u admin:admin -X POST http://localhost:4503/system/console/jmx/com.adobe.granite:type=ScriptMBean?action=shutdown

# Wait for a few seconds to allow AEM to shut down properly
sleep 30

echo "Shutdown tasks complete. Stopping container."
