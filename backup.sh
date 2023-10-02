cd /etc/gitlab

gitlab-ctl restart
gitlab-backup create BACKUP=dump
aws s3 cp gitlab.rb s3://gitlab-wattio/gitlab.rb
aws s3 cp gitlab-secrets.json s3://gitlab-wattio/gitlab-secrets.json