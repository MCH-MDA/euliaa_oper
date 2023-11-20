# set up S3 environment for administrating and mounting buckets

path_scripts=$(dirname "$0")
source $path_scripts/get_config.sh


echo "installing s3fs and s3cmd"
echo "-------------------------"

sudo apt install -y s3fs
sudo apt install -y s3cmd



echo "configuring s3fs (for mounting buckets)"
echo "---------------------------------------"

echo $S3_ACCESS_KEY:$S3_SECRET_KEY | sudo tee /root/.passwd-s3fs
sudo chmod 600 /root/.passwd-s3fs



echo "configuring s3cmd (for bucket admin)"
echo "------------------------------------"

cat >/$HOME/.s3cfg <<EOT
host_base = $S3_HOST_BASE
access_key = $S3_ACCESS_KEY
secret_key = $S3_SECRET_KEY
EOT

