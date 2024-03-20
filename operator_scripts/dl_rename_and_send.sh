#!/bin/bash
#
# The script first renames the raw files of your instruments to follow the naming convention for E-PROFILE.
# In a second step the script sends all processed data to E-PROFILE by FTP. This step can be disabled
# for internal usage or testing.
# The script can treat data from multiple instruments that have identical cycle duration and start times
# at once if they are available at a common central server (see example input below).
#
#
# License: BSD 3-Clause License
# Author: Rolf Ruefenacht, MeteoSwiss / E-PROFILE, 2024
 

# INPUT

# measurement cycle specification
consider_last_n_min=3000  # consider files generated in the last minutes. Set to something cycle duration if your $data_dir is normal input directory. Can set to something larger in order to catch up for short transmission outages when straming from a dedicated input directory where files are just copies from the originals and remove_infile=1 can be used
remove_infile=1  # 0: copy file from input directoy, but leave original there 1: remove file from input directory upon transmission (facilitates handling. CARE: Only set =1 if your $data_dirs are not your master place where you want to collect your data. In such a case prefer setting reasonable consider_last_n_min parameter

# instrument file and data dir specification
# (requires same length of arrays data_dirs, prefixes_org and prefixes_eprof)
eprof_dir=/data/pay/REM/ACQ/WIND_LIDAR/to_eprofile/out/  # folder where E-PROFILE (renamed) files are saved to before sending to FTP
# folders where (copies of) original files are located (include tailing slash)
data_dirs=(
    /data/pay/REM/ACQ/WIND_LIDAR/to_eprofile/in/
    /data/pay/REM/ACQ/WIND_LIDAR/to_eprofile/in/
    /data/pay/REM/ACQ/WIND_LIDAR/to_eprofile/in/
    )
# prefixes of the original filenames (part of filename before timestamp for Vaisala Windcube or before obs type for Halo). CARE: Case of filename might change depending on firmware version
prefixes_orig=(
    WLS200S-196_  # upper-case 'S' for this model
    WLS200s-197_  # lower-case 's' for this model
    WLS200S-199_  # upper-case 'S' for this model
    )
# prefixes of the filenames to be sent to E-PROFILE (part of filename before timestamp for Vaisala Windcube or before obs type for Halo)
prefixes_eprof=(
    DWL_raw_SHAWL_
    DWL_raw_PAYWL_
    DWL_raw_GREWL_
    )
    
extension=.nc.gz  # take care: either send .nc files only or .nc.gz files only in order to avoid duplicate submissions


#ftp settings
do_ftp=1  # 1: send via ftp to target specified below (files removed from eprof_dir); 0:don't send (just for testing, files remain in eprof_dir)
ftp_host=ftpweb.metoffice.gov.uk
ftp_folder=deposit/wind-lidar/
ftp_user=____YOUR_USER____
ftp_pw=____YOUR_PASSWORD____



# END OF INPUT






# PREPARATION OF FILES FOR SUBMISSION

# this part can be repeated for multiple instruments with same cycle duration and starts if wanting to use the same FTP send folder and command
# in this case alter the variables data_dir, prefix_orig, prefix_eprof here. 

# preparing
umask 002  # give read and write permission to you and your group for output files (execute disablled by default)

#loop over all stations
for n in "${!prefixes_eprof[@]}"  
do
    data_dir=${data_dirs[$n]}
    prefix_orig=${prefixes_orig[$n]}
    prefix_eprof=${prefixes_eprof[$n]}
    len_prefix_orig=${#prefix_orig}
    
    echo "===================================="
    echo "preparing allowed DL files matching $data_dir$prefix_orig*"

    # getting data
    files=$(find $data_dir -maxdepth 1 \( -name "$prefix_orig*$extension" \) -mmin -$consider_last_n_min)

    # copying and renaming files to eprof_dir
    for file in $files
    do
        echo $file
        bn_file_in=$(basename $file)
        bn_file_out=$(echo "$bn_file_in" | sed "s/$prefix_orig/$prefix_eprof/")
        file_out=$eprof_dir$bn_file_out
        if [ "$remove_infile" -ne 0 ]
        then
            mv -v $file $file_out
        else
            cp -v $file $file_out
        fi
    done
done

# END OF PREPARATION OF FILES FOR SUBMISSION




# PUSH ALL DL FILES IN eprof_dir TO FTP AND EMPTY DIR
if [ "$do_ftp" -ne 0 ]
then
    echo "===================================="
    echo "pushing data in $eprof_dir to E-PROFILE hub"

    path_here=$(pwd)
    cd $eprof_dir

    ftp -n $ftp_host <<END_SCRIPT
    quote USER $ftp_user
    quote PASS $ftp_pw
    prompt off
    binary
    cd $ftp_folder
    mput *$extension

    quit
END_SCRIPT

    cd $path_here

    echo "emptying $eprof_dir"
    rm -v "$eprof_dir"*$extension # rely on fact that only this script is writing and deleting in $eprof_dir
else
    echo "did not push to ftp as do_ftp was set to 0"
fi

# FTP AND CLEANUP DONE
