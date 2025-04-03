# This is the main script orchestrating the whole set up of a new VM from scratch

path_scripts=$(dirname "$0")

echo 
echo "setting up new VM from scratch - stay around, user input will be required"
echo "=============================="
echo

chmod a+x $path_scripts/*.sh  # make sure all bash scripts are executable

# check config can be read, otherwise exit without further action
echo "Loading config..."
$path_scripts/get_config.sh || exit $?

echo "Python updates and environment creation..."
$path_scripts/update_python.sh

echo "Installing s3 buckets..."
$path_scripts/install_s3.sh
# $path_scripts/s3_create_buckets.sh eprofile-dl-raw eprofile-dl-l1  # comment this out if buckets alredy exist. Also, creating buckets in morpheus is preferrable (buckets created in command line don't show up in morpheus)
$path_scripts/s3_automount_buckets.sh euliaa-test # mount buckets

$path_scripts/install_euliaa_proc.sh # download and install processing scripts

# OLD - E-PROFILE
# $path_scripts/import_eprofile_config.sh
# $path_scripts/write_cron.sh
