#!/bin/bash

# Define the variable with a default value
AWS_BUCKET_NAME="gitlab-wattio"

# Check if the first command-line argument is provided
if [ $# -eq 1 ]; then
    AWS_BUCKET_NAME="$1"
fi

# Change directory to /etc/gitlab-wattio
cd /etc/gitlab-wattio

# Remove files and directories
rm -rf dump_gitlab_backup.tar gitlab.rb gitlab-secrets.json

# Copy files from S3 with the variable
aws s3 cp s3://$AWS_BUCKET_NAME/ . --recursive

# Reconfigure GitLab
gitlab-ctl reconfigure

# Restart GitLab
gitlab-ctl restart

# Change ownership of dump_gitlab_backup.tar
chown git:git dump_gitlab_backup.tar

# Stop Puma and Sidekiq
gitlab-ctl stop puma
gitlab-ctl stop sidekiq

# Restore GitLab backup
gitlab-backup restore BACKUP=dump force=yes

# Restart GitLab
gitlab-ctl restart