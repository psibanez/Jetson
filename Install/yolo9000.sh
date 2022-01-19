
https://github.com/philipperemy/yolo-9000

replace darknet with
for cuda dnn
https://github.com/tiagoshibata/darknet

replace convolutional_layer.c with
https://github.com/arnoldfychen/darknet/blob/master/src/convolutional_layer.c


NVCC_PATH=/usr/local/cuda/bin/nvcc
export CUDACXX=$NVCC_PATH
export PATH=${PATH}:/usr/local/cuda/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64

patch makefile

cd darknet make

for python:
https://programmerclick.com/article/2526121103/

net = load_net("cfg/tiny-yolo.cfg".encode('utf-8'), "tiny-yolo.weights".encode('utf-8'), 0)
meta = load_meta("cfg/coco.data".encode('utf-8'))
r = detect(net, meta, "data/dog.jpg".encode('utf-8'))
cd yolo

To avoid segmentation fault - Remeber to put data/air9k.tree and data/air9k.map under the same folder of your app.