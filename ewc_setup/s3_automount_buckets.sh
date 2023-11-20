# designate S3 buckets for automount to local file system according to config in ewc.conf. 
# Pass bucket names as arguments to script

path_scripts=$(dirname "$0")
$path_scripts/get_config.sh


for bucket in ${@}
do
    sudo mkdir -p $S3_MOUNTPOINT/$bucket
    echo "s3fs#$bucket /$S3_MOUNTPOINT/$bucket fuse _netdev,allow_other,nodev,nosuid,uid=$(id -u),gid=$(id -g),use_path_request_style,url=$S3_HOST_BASE 0 0" | sudo tee -a /etc/fstab
done

sudo mount -a