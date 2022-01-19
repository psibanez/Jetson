
https://github.com/philipperemy/yolo-9000

replace darknet with
for cuda dnn
https://github.com/tiagoshibata/darknet

replace convolutional_layer.c with
https://github.com/arnoldfychen/darknet/blob/master/src/convolutional_layer.

for python:
https://programmerclick.com/article/2526121103/

net = load_net("cfg/tiny-yolo.cfg".encode('utf-8'), "tiny-yolo.weights".encode('utf-8'), 0)
meta = load_meta("cfg/coco.data".encode('utf-8'))
r = detect(net, meta, "data/dog.jpg".encode('utf-8'))
