sudo apt install -y libssl1.0-dev
sudo apt install -y nodejs-dev
sudo apt install -y node-gyp
sudo apt install -y npm

###### bazel
sudo npm install -g @bazel/bazelisk

bazel


############# rensorflow-rt
# https://forums.developer.nvidia.com/t/tensorflow-no-matching-distribution/110062
wget https://developer.download.nvidia.com/compute/redist/jp/v43/tensorflow-gpu/tensorflow_gpu-1.15.0+nv19.12-cp36-cp36m-linux_aarch64.whl
sudo pip3 install tensorflow_gpu-1.15.0+nv19.12-cp36-cp36m-linux_aarch64.whl
