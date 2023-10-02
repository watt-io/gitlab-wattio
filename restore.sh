cd /etc/gitlab

rm -rf dump_gitlab_backup.tar gitlab.rb gitlab-secrets.json
aws s3 cp s3://gitlab-wattio/ . --recursive
gitlab-ctl reconfigure
gitlab-ctl restart
chown git:git dump_gitlab_backup.tar
gitlab-ctl stop puma
gitlab-ctl stop sidekiq
gitlab-backup restore BACKUP=dump force=yes
gitlab-ctl restart