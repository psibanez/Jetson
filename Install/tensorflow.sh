https://qengineering.eu/install-tensorflow-2.4.0-on-jetson-nano.html

pip3 uninstall numpy && pip3 install numpy==1.18.5.

# get a fresh start (remember, the 64-bit OS is still under development)
sudo apt-get update
sudo apt-get upgrade
# install pip and pip3
sudo apt-get install python-pip python3-pip
# remove old versions, if not placed in a virtual environment (let pip search for them)
sudo pip uninstall tensorflow
sudo pip3 uninstall tensorflow
# install the dependencies (if not already onboard)
sudo apt-get install gfortran
sudo apt-get install libhdf5-dev libc-ares-dev libeigen3-dev
sudo apt-get install libatlas-base-dev libopenblas-dev libblas-dev
sudo apt-get install liblapack-dev
sudo -H pip3 install Cython==0.29.21
# install h5py with Cython version 0.29.21 (± 6 min @1950 MHz)
sudo -H pip3 install h5py==2.10.0
sudo -H pip3 install -U testresources numpy
# upgrade setuptools 39.0.1 -> 53.0.0
sudo -H pip3 install --upgrade setuptools
sudo -H pip3 install pybind11 protobuf google-pasta
sudo -H pip3 install -U six mock wheel requests gast
sudo -H pip3 install keras_applications --no-deps
sudo -H pip3 install keras_preprocessing --no-deps
# install gdown to download from Google drive
sudo -H pip3 install gdown
# download the wheel
gdown https://drive.google.com/uc?id=1DLk4Tjs8Mjg919NkDnYg02zEnbbCAzOz
# install TensorFlow (± 12 min @1500 MHz)
sudo -H pip3 install tensorflow-2.4.1-cp36-cp36m-linux_aarch64.whl

########## addon
# download the wheel
wget https://github.com/Qengineering/TensorFlow-Addons-Jetson-Nano/raw/main/tensorflow_addons-0.13.0.dev0-cp36-cp36m-linux_aarch64.whl
# install the wheel
sudo -H pip3 install tensorflow_addons-0.13.0.dev0-cp36-cp36m-linux_aarch64.whl