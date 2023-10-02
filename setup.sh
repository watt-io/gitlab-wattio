# Verifica se exatamente 3 parâmetros foram passados
if [ $# -ne 3 ]; then
    echo "Usage: $0 AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY DEFAULT_REGION"
    exit 1
fi

sudo apt update
sudo apt upgrade -y
# TODO: conseguir pular o popup de configuração do postfix

sudo apt install awscli -y
aws configure set aws_access_key_id "$1"
aws configure set aws_secret_access_key "$2"
aws configure set default_region "$3"

curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
apt-get install -y gitlab-ce=16.4.0-ce.0
