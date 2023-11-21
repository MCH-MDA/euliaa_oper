# get config in file and set entries as environment variables.
# This file has to be sourced in order for variables to be available to caller

FILENAME_CONF=ewc.conf  # name of the config file. Will locate this filename in same directory as this script

path_scripts=$(dirname "${BASH_SOURCE[-1]}")
file_conf=$path_scripts/$FILENAME_CONF

if [ ! -f "$file_conf" ]; then
    echo "configuration file $file_conf does not exist! To make the package run do the following:"
    echo "    1. copy ewc_example.conf to ewc.conf"
    echo "    2. fill in your secrets (from M:\pay-proj\pay\E-PROFILE\EProfileLogins.kdbx)"
    echo "    3. re-run your script"
    exit 2
fi

source $file_conf
