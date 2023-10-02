#!/bin/bash

# Check if exactly 3 parameters were passed, and display usage if not
if [ $# -ne 3 ]; then
    echo "Usage: $0 AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY DEFAULT_REGION"
    exit 1
fi

apt update # Update package list
apt-mark hold gitlab-ce # Mark GitLab CE as held to prevent accidental upgrades
apt upgrade -y # Upgrade all packages
cp crontab /etc/crontab # Copy crontab file to /etc/crontab

# TODO: Find a way to configure Postfix without manual intervention

# Install AWS CLI and configure AWS credentials and default region
apt install awscli -y
aws configure set aws_access_key_id "$1"
aws configure set aws_secret_access_key "$2"
aws configure set default_region "$3"

# Add GitLab repository and install a specific version of GitLab CE
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
apt-get install -y gitlab-ce=16.4.0-ce.0