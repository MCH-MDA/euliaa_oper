# set up S3 environment for administrating and mounting buckets

path_scripts=$(dirname "$0")
source $path_scripts/get_config.sh


echo "installing s3fs and s3cmd"
echo "-------------------------"

sudo apt install -y s3fs
sudo apt install -y s3cmd
sudo apt install -y awscli


echo "configuring s3fs (for mounting buckets)"
echo "---------------------------------------"

echo $S3_ACCESS_KEY:$S3_SECRET_KEY | sudo tee /root/.passwd-s3fs
sudo chmod 600 /root/.passwd-s3fs



echo "configuring s3cmd (for bucket admin)"
echo "------------------------------------"

cat >/$HOME/.s3cfg <<EOT
host_base = $S3_HOST_BASE
host_bucket = 
access_key = $S3_ACCESS_KEY
secret_key = $S3_SECRET_KEY
use_https = True
check_ssl_certificate = False
EOT

echo "configuring awscli"
echo "------------------------------------"

mkdir -p /$HOME/.aws
cat >/$HOME/.aws/config <<EOT
[default]
endpoint_url = $S3_HOST_BASE
EOT

cat >/$HOME/.aws/credentials <<EOT
[default]
aws_access_key_id = $S3_ACCESS_KEY
aws_secret_access_key = $S3_SECRET_KEY
EOT