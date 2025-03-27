# clone eprofile_config

base_dir="$HOME"  # directory where to import the config files


echo 
echo "importing eprofile_config from github"
echo "================================"
echo


act_path=$(pwd)
cd $base_dir
git clone https://github.com/MeteoSwiss/eprofile_config.git
cd $act_path
