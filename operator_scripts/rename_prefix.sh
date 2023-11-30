orig_prefix='WLS200s-197_'
eprof_prefix='DL_PAY_A_'
ext='.nc'
dir_in="$HOME/tmp"
dir_out="$HOME/tmp"


len_orig_prefix=${#orig_prefix}

for file in $dir_in/$orig_prefix*$ext
do
    bn=$(basename "$file")
    cp $file $dir_in/$eprof_prefix${bn:$len_orig_prefix}
done

