#!/bin/bash -i

# This is the main script orchestrating the whole set up of a new VM from scratch

path_scripts=$(dirname "$0")

echo 
echo "SETTING UP NEW VM FROM SCRATCH - STAY AROUND, USER INPUT WILL BE REQUIRED"
echo "=============================="
echo
echo

chmod a+x $path_scripts/*.sh  # make sure all bash scripts are executable

# check config can be read, otherwise exit without further action
$path_scripts/get_config.sh || exit $?

echo "PYTHON UPDATES AND ENVIRONMENT CREATION"
echo "=============================="
echo
$path_scripts/update_python.sh

echo "INSTALLING S3 BUCKETS"
echo "=============================="
echo
$path_scripts/install_s3.sh
# $path_scripts/s3_create_buckets.sh eprofile-dl-raw eprofile-dl-l1  # comment this out if buckets alredy exist. Also, creating buckets in morpheus is preferrable (buckets created in command line don't show up in morpheus)
$path_scripts/s3_automount_buckets.sh euliaa-test # mount buckets

echo "DOWNLOAD AND INSTALL EULIAA PROC SCRIPTS"
echo "=============================="
echo
source ~/.bashrc  # needed for proper poetry installation
$path_scripts/install_euliaa_proc.sh # download and install processing scripts

echo
echo
echo "DONE SETTING UP VM!"
echo "=============================="
