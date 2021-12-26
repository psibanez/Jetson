# https://github.com/dusty-nv/jetson-inference/blob/master/docs/building-repo-2.md

cd ~/workspace


sudo apt-get update
sudo apt-get install git cmake libpython3-dev python3-numpy dialog
git clone --recursive https://github.com/dusty-nv/jetson-inference
cd jetson-inference
mkdir build
cd build
cmake ../
make -j$(nproc)
sudo make install
sudo ldconfig


### models
# https://github.com/dusty-nv/jetson-inference/releases

cd ~/workspace/jetson-inference/data/networks/
wget https://github.com/dusty-nv/jetson-inference/releases/download/model-mirror-190618/GoogleNet.tar.gz


# https://qengineering.eu/install-pytorch-on-jetson-nano.html