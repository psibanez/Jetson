#https://qengineering.eu/install-pytorch-on-jetson-nano.html

# install the dependencies (if not already onboard)
# sudo apt-get install python3-pip libjpeg-dev libopenblas-dev libopenmpi-dev libomp-dev
# sudo -H pip3 install future
# sudo pip3 install -U --user wheel mock pillow
# sudo -H pip3 install testresources
# upgrade setuptools 47.1.1 -> 58.3.0
# sudo -H pip3 install --upgrade setuptools
# sudo -H pip3 install Cython
# install gdown to download from Google drive
# sudo -H pip3 install gdown
# download the wheel
# gdown https://drive.google.com/uc?id=1TqC6_2cwqiYacjoLhLgrZoap6-sVL2sd
# install PyTorch 1.10.1
# sudo -H pip3 install torch-1.10.0a0+git36449ea-cp36-cp36m-linux_aarch64.whl
# clean up
# rm torch-1.10.0a0+git36449ea-cp36-cp36m-linux_aarch64.whl


#update protobuf (3.15.5)

#torch 1.6
#cd jetson-inference/tools
#sudo bash install-pytorchsh

#Install PyTorch 1.10 for Python 3
#https://qengineering.eu/install-pytorch-on-jetson-nano.html

#get a fresh start
sudo apt-get update
sudo apt-get upgrade
#the dependencies
sudo apt-get install ninja-build git cmake
sudo apt-get install libjpeg-dev libopenmpi-dev libomp-dev ccache
sudo apt-get install libopenblas-dev libblas-dev libeigen3-dev
sudo -H pip3 install -U --user wheel mock pillow
sudo -H pip3 install testresources
#upgrade setuptools 47.1.1 -> 58.3.0
sudo -H pip3 install -U setuptools
sudo -H pip3 install scikit-build
#download PyTorch 1.10.0 with all its libraries
git clone -b v1.10.1 --depth=1 --recursive https://github.com/pytorch/pytorch.git
cd pytorch
#one command to install several dependencies in one go
#installs future, numpy, pyyaml, requests
#setuptools, six, typing_extensions, dataclasses


sudo -H pip3 install typing-extension

sudo apt-get install clang

# patch Python 1.10 :       ~/pytorch/aten/src/ATen/cpu/vec/vec256/vec256_float_neon.h
#Around line 28 add #if defined(__clang__) ||(__GNUC__ > 8 || (__GNUC__ == 8 && __GNUC_MINOR__ > 3)) and the matching closure #endif.

#~/pytorch/aten/src/ATen/cuda/CUDAContext.cpp
#Around line 24 add an extra line device_prop.maxThreadsPerBlock = device_prop.maxThreadsPerBlock / 2;

#~/pytorch/aten/src/ATen/cuda/detail/KernelUtils.h
#In line 26 change the constant from 1024 to 512.

#Python 1.10 :    common.h is no longer in use.

# set NINJA parameters
export BUILD_CAFFE2_OPS=OFF
export USE_FBGEMM=OFF
export USE_FAKELOWP=OFF
export BUILD_TEST=OFF
export USE_MKLDNN=OFF
export USE_NNPACK=OFF
export USE_XNNPACK=OFF
export USE_QNNPACK=OFF
export USE_PYTORCH_QNNPACK=OFF
export USE_CUDA=ON
export USE_CUDNN=ON
export TORCH_CUDA_ARCH_LIST="5.3;6.2;7.2"
export USE_NCCL=OFF
export USE_SYSTEM_NCCL=OFF
export USE_OPENCV=OFF
export MAX_JOBS=4
# set path to ccache
export PATH=/usr/lib/ccache:$PATH
# set clang compiler
export CC=clang
export CXX=clang++
# create symlink to cublas
sudo ln -s /usr/lib/aarch64-linux-gnu/libcublas.so /usr/local/cuda/lib64/libcublas.so

### my path:

#/home/pi/workspace/pytorch/tools/setup_helpers/cmake.py
        cmake_command = 'cmake'
        return cmake_command    # <------- add and comment below
        # if IS_WINDOWS:
            # return cmake_command
        # cmake3 = which('cmake3')
        # cmake = which('cmake')
        # if cmake3 is not None and CMake._get_version(cmake3) >= distutils.version.LooseVersion("3.10.0"):
            # cmake_command = 'cmake3'
            # return cmake_command
        # elif cmake is not None and CMake._get_version(cmake) >= distutils.version.LooseVersion("3.10.0"):
            # return cmake_command
        # else:
            # raise RuntimeError('no cmake or cmake3 with version >= 3.10.0 found')
            
# start the build
python3 setup.py bdist_wheel <------------------- pb

cd dist
sudo -H pip3 install torch-1.10.0a0+git36449ea-cp36-cp36m-linux_aarch64.whl


#torchvision  Used with PyTorch 1.10.0
# the dependencies
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev
sudo pip3 install -U pillow
# install gdown to download from Google drive, if not done yet
sudo -H pip3 install gdown
# download TorchVision 0.11.0
gdown https://drive.google.com/uc?id=1C7y6VSIBkmL2RQnVy8xF9cAnrrpJiJ-K
# install TorchVision 0.11.0
sudo -H pip3 install torchvision-0.11.0a0+fa347eb-cp36-cp36m-linux_aarch64.whl
# clean up
rm torchvision-0.11.0a0+fa347eb-cp36-cp36m-linux_aarch64.whl


###################### CAFFE
# https://qengineering.eu/install-caffe-on-jetson-nano.html





# https://github.com/pytorch/QNNPACK

############ vision ????????
cd ~/workspace
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install mc -y
sudo apt-get remove python3-pip
sudo apt-get install python3-pip
wget https://nvidia.box.com/shared/static/veo87trfaawj5pfwuqvhl6mzc5b55fbj.whl -O torch-1.1.0a0+b457266-cp36-cp36m-linux_aarch64.whl
sudo -H pip3 install numpy torch-1.1.0a0+b457266-cp36-cp36m-linux_aarch64.whl
sudo apt-get install libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev
git clone https://github.com/pytorch/vision
cd vision
sudo python3 setup.py install
sudo -H pip3 install -U protobuf
sudo -H pip3 install --upgrade future
sudo -H pip3 install matplotlib
sudo apt-get install libcanberra-gtk-module
sudo apt-get install libjpeg-dev zlib1g-dev
sudo -H pip3 install Pillow
sudo apt-get install flac ffmpeg
sudo apt update && sudo apt install python3-pyaudio
sudo apt-get install python3-dev

sudo apt-get install portaudio19-dev python-all-dev python3-all-dev
sudo -H pip3 install pyaudio
sudo -H pip3 install pysine

#################################################
#https://pypi.org/project/Jetson.GPIO/
git clone https://github.com/NVIDIA/jetson-gpio.git

https://github.com/NVIDIA/jetson-gpio




