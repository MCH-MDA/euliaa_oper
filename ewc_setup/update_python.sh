# This script installs a more recent version of python. It also sets alias for python and python3
# to this new version and upgrades pip (needed for installing from pyproject.toml)


PYTHON_VERSION=python3.8

echo 
echo "Installing $PYTHON_VERSION and updating pip"
echo "========================================"
echo

# the following does not work on EWC and is not needed for python3.8
# # add deadsnakes as some python versions are not automatically available via apt 
# sudo add-apt-repository ppa:deadsnakes/ppa
# sudo apt update

sudo apt install -y $PYTHON_VERSION


# set new python as default for...
full_py_src=$(which $PYTHON_VERSION)

# ... python3
sudo update-alternatives --install /usr/bin/python3 python3 $full_py_src 1
sudo update-alternatives --set python3 $full_py_src

# ... python (instead of python 2)
sudo update-alternatives --install /usr/bin/python python $full_py_src 1
sudo update-alternatives --set python $full_py_src


# install and upgrade pip (so that installing from pyproject.toml works in install_mwr_l12l2)
sudo apt install -y python3-pip
python3 -m pip install --upgrade pip