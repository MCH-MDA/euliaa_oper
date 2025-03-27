repo_name=euliaa_postproc
repo_url=https://github.com/MCH-MDA/euliaa_postproc.git
base_dir="$HOME"  

echo 
echo "installing EULIAA processing scripts from github"
echo "================================================"
echo


act_path=$(pwd)
cd $base_dir
git clone $repo_url
cd $repo_name

source $base_dir/.env_euliaa/bin/activate
poetry install # Install dependencies in pyproject.toml in the env_euliaa environment
cd $act_path
