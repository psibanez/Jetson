# CUDA
#https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=arm64-sbsa&Compilation=Native&Distribution=Ubuntu&target_version=18.04&target_type=runfile_local

wget https://developer.download.nvidia.com/compute/cuda/11.6.0/local_installers/cuda_11.6.0_510.39.01_linux_sbsa.run
sudo sh cuda_11.6.0_510.39.01_linux_sbsa.run

#ONNX
#https://github.com/onnx/onnx/releases/tag/v1.9.0
sudo -H pip3 install onnx

#PYTORCH 1.9
#https://qengineering.eu/install-pytorch-on-jetson-nano.html
# get a fresh start
sudo apt-get update
sudo apt-get upgrade
# the dependencies
sudo apt-get install ninja-build git cmake
sudo apt-get install libjpeg-dev libopenmpi-dev libomp-dev ccache
sudo apt-get install libopenblas-dev libblas-dev libeigen3-dev
sudo pip3 install -U --user wheel mock pillow
sudo -H pip3 install testresources
# upgrade setuptools 47.1.1 -> 57.0.0
sudo -H pip3 install -U setuptools
sudo -H pip3 install scikit-build
# download PyTorch 1.9.0 with all its libraries
git clone -b v1.9.0 --depth=1 --recursive https://github.com/pytorch/pytorch.git
cd pytorch
# one command to install several dependencies in one go
# installs future, numpy, pyyaml, requests
# setuptools, six, typing_extensions, dataclasses
sudo pip3 install -r requirements.txt




Used with PyTorch 1.9.0
# the dependencies
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev
sudo pip3 install -U pillow
# install gdown to download from Google drive, if not done yet
sudo -H pip3 install gdown
# download TorchVision 0.10.0
gdown https://drive.google.com/uc?id=1tU6YlPjrP605j4z8PMnqwCSoP6sSC91Z
# install TorchVision 0.10.0
sudo -H pip3 install torchvision-0.10.0a0+300a8a4-cp36-cp36m-linux_aarch64.whl
# clean up
rm torchvision-0.10.0a0+300a8a4-cp36-cp36m-linux_aarch64.whl

export PYTHONPATH=/usr/local/lib/python3.6/dist-packages/


#TENSORRT
#https://docs.nvidia.com/deeplearning/tensorrt/install-guide/index.html
Download the TensorRT tar file that matches the CPU architecture and CUDA version you are using.
Choose where you want to install TensorRT. This tar file will install everything into a subdirectory called TensorRT-8.x.x.x.
Unpack the tar file.
version="8.x.x.x"
arch=$(uname -m)
cuda="cuda-x.x"
cudnn="cudnn8.x"
tar xzvf TensorRT-${version}.Linux.${arch}-gnu.${cuda}.${cudnn}.tar.gz
Where:
8.x.x.x is your TensorRT version
cuda-x.x is CUDA version 10.2 or 11.4
cudnn8.x is cuDNN version 8.2
This directory will have sub-directories like lib, include, data, etc…
ls TensorRT-${version}
bin  data  doc  graphsurgeon  include  lib  onnx_graphsurgeon  python  samples  targets  TensorRT-Release-Notes.pdf  uff
Add the absolute path to the TensorRTlib directory to the environment variable LD_LIBRARY_PATH:
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<TensorRT-${version}/lib>
Install the Python TensorRT wheel file.
cd TensorRT-${version}/python

python3 -m pip install tensorrt-*-cp3x-none-linux_x86_64.whl
Install the Python UFF wheel file. This is only required if you plan to use TensorRT with TensorFlow.
cd TensorRT-${version}/uff

python3 -m pip install uff-0.6.9-py2.py3-none-any.whl
Check the installation with:
which convert-to-uff
Install the Python graphsurgeon wheel file.
cd TensorRT-${version}/graphsurgeon

python3 -m pip install graphsurgeon-0.4.5-py2.py3-none-any.whl
Install the Python onnx-graphsurgeon wheel file.
cd TensorRT-${version}/onnx_graphsurgeon
	
python3 -m pip install onnx_graphsurgeon-0.3.12-py2.py3-none-any.whl
Verify the installation:
Ensure that the installed files are located in the correct directories. For example, run the tree -d command to check whether all supported installed files are in place in the lib, include, data, etc… directories.
Build and run one of the shipped samples, for example, sampleMNIST in the installed directory. You should be able to compile and execute the sample without additional settings. For more information, refer to sampleMNIST.
The Python samples are in the samples/python directory.


