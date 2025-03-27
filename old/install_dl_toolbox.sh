# clone dl_toolbox and install it with its dependencies. Needs pip>21.3 installed, hence first run update_python.sh

repo_name=dl_toolbox_runner
repo_url=https://github.com/MeteoSwiss/dl_toolbox_runner.git
base_dir="$HOME"  # directory where to install code in as a subdirectory dl_toolbox_nrt



echo 
echo "installing dl_toolbox from github"
echo "================================="
echo


act_path=$(pwd)
cd $base_dir
git clone $repo_url
cd $repo_name
source $base_dir/.env_dl/bin/activate
pip3 install -e .  # Use virtual environment here and install the package as editable
cd $act_path
