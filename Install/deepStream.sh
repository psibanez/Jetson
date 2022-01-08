#https://developer.nvidia.com/deepstream-getting-started

#https://github.com/dusty-nv/jetson-inference/blob/master/docs/jetpack-setup-2.md
##### JETSON INFERENCE
sudo apt-get update
sudo apt-get install git cmake libpython3-dev python3-numpy
git clone --recursive https://github.com/dusty-nv/jetson-inference
cd jetson-inference
mkdir build
cd build
cmake ../
cmake -DENABLE_NVMM=OFF ../
make -j$(nproc)
sudo make install
sudo ldconfig

#test ./imagenet rtp://@:1234 set --input-codec=h264

#https://github.com/dusty-nv/jetson-inference/blob/master/docs/imagenet-console-2.md

cd ~/Download
#wget https://developer.nvidia.com/deepstream-6.0_6.0.0-1_arm64deb
sudo dpkg -i deepstream-6.0_6.0.0-1_arm64debsudo apt install -f
sudo apt install -f

# https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/releases
wget https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/releases/download/v1.1.0/pyds-1.1.0-py3-none-linux_aarch64.whl
sudo -H pip3 install pyds-1.1.0-py3-none-linux_aarch64.whl

#https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/blob/master/HOWTO.md

#https://gstreamer.freedesktop.org/src/gst-python/
#download  gst-python-1.14.5.tar.gz

#https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/blob/master/HOWTO.md#prereqs
#https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/blob/master/bindings/README.md
sudo apt install -y git python-dev python3 python3-pip python3.6-dev python3.8-dev cmake g++ build-essential \
    libglib2.0-dev libglib2.0-dev-bin python-gi-dev libtool m4 autoconf automake

cd /opt/nvidia/deepstream/deepstream-6.0/sources/deepstream_python_apps/apps/deepstream-test1
python3 deepstream_test_1.py /opt/nvidia/deepstream/deepstream-6.0/samples/streams/sample_720p.h264 

Please remove the cache rm ~/.cache/gstreamer-1.0/registry* and then run gst-inspect-1.0 and look for warnings/criticals from the plugin that was blacklisted.
and try again.


# https://developer.nvidia.com/embedded/twodaystoademo#hello_ai_world
# https://github.com/dusty-nv/jetson-inference/blob/master/docs/building-repo-2.md

sudo apt-get update
sudo apt-get install git cmake libpython3-dev python3-numpy
git clone --recursive https://github.com/dusty-nv/jetson-inference
cd jetson-inference
mkdir build
cd build
cmake ../
make -j$(nproc)
sudo make install
sudo ldconfig	



cd /opt/nvidia/deepstream/deepstream/sources/apps/sample_apps/deepstream-test1
/opt/nvidia/deepstream/deepstream/bin/deepstream-test1-app /opt/nvidia/deepstream/deepstream/samples/streams/sample_720p.h264









