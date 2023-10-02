#!/bin/bash

# Define the variable with a default value
BUCKET_NAME="gitlab-wattio"

# Check if the first command-line argument is provided
if [ $# -eq 1 ]; then
    BUCKET_NAME="$1"
fi

# Change directory to /etc/gitlab
cd /etc/gitlab_ce_scripts

# Restart GitLab
gitlab-ctl restart

# Create a GitLab backup
gitlab-backup create BACKUP=dump

# Copy configuration files to S3 with the variable
aws s3 cp gitlab.rb s3://$BUCKET_NAME/gitlab.rb
aws s3 cp gitlab-secrets.json s3://$BUCKET_NAME/gitlab-secrets.json
