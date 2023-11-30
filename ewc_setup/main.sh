# This is the main script orchestrating the whole set up of a new VM from scratch

path_scripts=$(dirname "$0")

echo 
echo "setting up new VM from scratch"
echo "=============================="
echo

chmod a+x $path_scripts/*.sh  # make sure all bash scripts are executable

# check config can be read, otherwise exit without further action
$path_scripts/get_config.sh || exit 2

$path_scripts/update_python.sh
$path_scripts/install_mwr_l12l2.sh
$path_scripts/install_s3.sh
$path_scripts/s3_create_buckets.sh eprofile-dl-raw eprofile-dl-l1  # comment this out if buckets alredy exist
$path_scripts/s3_automount_buckets.sh eprofile-dl-raw eprofile-dl-l1

