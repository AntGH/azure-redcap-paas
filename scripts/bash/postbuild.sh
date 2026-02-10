#!/bin/bash

# Copyright (c) Microsoft Corporation
# All rights reserved.
#
# MIT License

echo "Hello from postbuild.sh"

####################################################################################
#
# Call the install.php file with the option to deploy the database schema.
# This runs synchronously and will take a few seconds to complete.
#
####################################################################################

curl -sS https://$WEBSITE_HOSTNAME/install.php?auto=1

echo -e "\nFinished running install.php"

# Append to the same deploy log used by deploy.sh ($stamp not available in PostDeploymentActions)
LOG=$(ls -t /home/site/log-*.txt 2>/dev/null | head -1)
if [ -n "$LOG" ]; then
  echo "PostDeploymentActions: postbuild.sh executed (install.php?auto=1 completed)." >> "$LOG"
fi

####################################################################################
#
# Update additional configuration settings including
# user file uploading settings to Azure Blob Storage
#
####################################################################################

#bash /home/site/repository/scripts/bash/install.sh
