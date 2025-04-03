# This script installs a more recent version of python. It also sets alias for python and python3
# to this new version and upgrades pip (needed for installing from pyproject.toml)


PYTHON_VERSION=python3.10
base_dir="$HOME"

echo 
echo "Installing $PYTHON_VERSION and updating pip"
echo "========================================"
echo

sudo apt install -y $PYTHON_VERSION

# set new python as default for...
full_py_src=$(which $PYTHON_VERSION)

# ... python3
sudo update-alternatives --install /usr/bin/python3 python3 $full_py_src 1
sudo update-alternatives --set python3 $full_py_src

# ... python (instead of python 2)
sudo update-alternatives --install /usr/bin/python python $full_py_src 1
sudo update-alternatives --set python $full_py_src


# install and upgrade pip (so that installing from pyproject.toml works)
sudo apt install -y python3-pip
python3 -m pip install --upgrade pip

# Install venv 
echo
echo "Installing $PYTHON_VERSION-venv and creating environment .env_euliaa"
echo "========================================"
echo
sudo apt install $PYTHON_VERSION-venv
python3 -m venv $base_dir/.env_euliaa # SET YOUR ENVIRONMENT NAME HERE

# Install poetry and required dependencies
python3 -m pip install --user pipx
python3 -m pipx ensurepath
# source ~/.bashrc
