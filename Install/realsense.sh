
# https://dev.intelrealsense.com/docs/open3d#section-obtaining-open-3-d-with-intel-real-sense-support
############################## realsense + open3d demo
#with open3d https://dev.intelrealsense.com/docs/open3d for realsense


####################################################### 1 - REALSENSE
https://www.jetsonhacks.com/2019/12/22/install-realsense-camera-in-5-minutes-jetson-nano/
https://github.com/JetsonHacksNano/installLibrealsense

./buildLibrealsense.sh

NVCC_PATH=/usr/local/cuda/bin/nvcc
export CUDACXX=$NVCC_PATH
export PATH=${PATH}:/usr/local/cuda/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64

cmake .. -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=Release -DFORCE_LIBUVC=true -DBUILD_PYTHON_BINDINGS=bool:true -DPYTHON_EXECUTABLE=$(which python3.6) -DBUILD_WITH_CUDA="$USE_CUDA" 
makesudo make install

#https://github.com/IntelRealSense/librealsense/issues/7540
#sudo make install have a wrong place for libs. Current it in dist-packages/pyrealsense2 folder, but python search in dist-packages.
#Finded workaround:
cd /usr/lib/python3/dist-packages/pyrealsense2
sudo cp pybackend2* ..
sudo cp pyrealsense2* ..




#####################################"################ openMP for open3d
# https://iq.opengenus.org/install-openmp-from-source/
git clone https://github.com/llvm-mirror/openmp.git
cd openmp
mkdir build
cd build
cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ ..
make
sudo make PREFIX=/usr/local/ install


####################################################### open3D
https://zenn.dev/ijiwarunahello/scraps/fee9925b443478
http://www.open3d.org/docs/release/arm.html#install-dependencies
http://www.open3d.org/docs/latest/compilation.html

sudo apt-get install -y apt-utils build-essential git cmake
sudo apt-get install -y python3 python3-dev python3-pip
sudo apt-get install -y xorg-dev libglu1-mesa-dev
sudo apt-get install -y libblas-dev liblapack-dev liblapacke-dev
sudo apt-get install -y libsdl2-dev libc++-7-dev libc++abi-7-dev libxi-dev
sudo apt-get install -y clang-7

https://issueexplorer.com/issue/isl-org/Open3D/2468
cd /usr/include/aarch64-linux-gnu
sudo ln -sf cblas-netlib.h cblas.h

# Clone
git clone --recursive https://github.com/intel-isl/Open3D
cd Open3D
git submodule update --init --recursive

util/install_deps_ubuntu.sh

mkdir build
cd build

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_CUDA_MODULE=ON \
    -DBUILD_GUI=ON \
    -DBUILD_TENSORFLOW_OPS=OFF \
    -DBUILD_PYTORCH_OPS=OFF \
    -DBUILD_UNIT_TESTS=OFF \
    -DCMAKE_INSTALL_PREFIX=~/workspace/open3d_install \
    -DPYTHON_EXECUTABLE=$(which python3) \
    -DBUILD_LIBREALSENSE=ON \
    -DUSE_SYSTEM_LIBREALSENSE=ON \
    -DENABLE_HEADLESS_RENDERING=ON \
    -DBUILD_EXAMPLES=ON \
    -DBUNDLE_OPEN3D_ML=OFF \
    -DOPEN3D_ML_ROOT=https://github.com/isl-org/Open3D-ML.git \
    -DBUILD_FILAMENT_FROM_SOURCE=ON \
    ..

# Build C++ library
make -j$(nproc)
sudo make install
sudo make install-pip-package


################ MOVIDIUS
# https://github.com/markjay4k/ncsdk-aarch64


###### Opencv + cuda + tengine + movidius ?