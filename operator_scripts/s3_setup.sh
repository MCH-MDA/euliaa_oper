# Install s3cmd
sudo apt install -y s3cmd
sudo apt install -y s3fs


echo "configuring s3cmd"
echo "---------------------------------------"

file_conf = '~/.s3cfg'
if [ ! -f "$file_conf" ]; then
    echo "configuration file $file_conf does not exist! To make the package run do the following:"
    echo "    1. Copy s3cfg_example to ~/.s3cfg"
    echo "    2. Edit ~/.s3cfg and add your access and secret keys"
    echo "    3. Re-run your script"
    exit 2
fi

s3cmd --configure # Not sure if this is necessary, or in which case (without this it didn't seem to work on my LabVM but to be checked)
source $file_conf


echo "configuring s3fs (for mounting buckets)"
echo "---------------------------------------"

echo $S3_ACCESS_KEY:$S3_SECRET_KEY | sudo tee /etc/.passwd-s3fs
sudo chmod 600 /etc/.passwd-s3fs
