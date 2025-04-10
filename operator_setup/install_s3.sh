# set up S3 environment for administrating and mounting buckets

path_scripts=$(dirname "$0")

# check config can be read, otherwise exit without further action
$path_scripts/get_config.sh || exit $?

source $path_scripts/get_config.sh


echo "installing s3fs and s3cmd"
echo "-------------------------"

sudo apt install -y s3fs
sudo apt install -y s3cmd


echo "configuring s3fs (for mounting buckets)"
echo "---------------------------------------"

echo $S3_ACCESS_KEY:$S3_SECRET_KEY | sudo tee /etc/passwd-s3fs
sudo chmod 600 /etc/passwd-s3fs


echo
echo
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
s3cmd --configure
