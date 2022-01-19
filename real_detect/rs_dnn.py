#!/usr/bin/python3
import pyrealsense2 as rs
import numpy as np
import cv2
import copy
import math

class ARC:
    def __init__(self):

        # prepare window
        self.frameNb = 0
        self.title = "RealSence"
        
        cv2.namedWindow(self.title, cv2.WINDOW_AUTOSIZE)
        cv2.setMouseCallback(self.title, self.draw)

        # Configure depth and color streams
        self.pipeline = rs.pipeline()
        config = rs.config()

        # Get device product line for setting a supporting resolution
        pipeline_wrapper = rs.pipeline_wrapper(self.pipeline)
        pipeline_profile = config.resolve(pipeline_wrapper)
        device = pipeline_profile.get_device()
        device_product_line = str(device.get_info(rs.camera_info.product_line))

        found_rgb = False
        for s in device.sensors:
            if s.get_info(rs.camera_info.name) == 'RGB Camera':
                found_rgb = True
                break
        if not found_rgb:
            print("The demo requires Depth camera with Color sensor")
            exit(0)

        config.enable_stream(rs.stream.depth, 640, 480, rs.format.z16, 30)

        if device_product_line == 'L500':
            config.enable_stream(rs.stream.color, 960, 540, rs.format.bgr8, 30)
        else:
            config.enable_stream(rs.stream.color, 640, 480, rs.format.bgr8, 30)

        # Start streaming
        self.pipeline.start(config)
        
        self.net = cv2.dnn.readNetFromCaffe("MobileNetSSD_deploy.prototxt",  "MobileNetSSD_deploy.caffemodel")
        #self.net = cv2.dnn.readNetFromCaffe("bvlc_googlenet.prototxt",  "bvlc_googlenet.caffemodel")
      
        self.expected = 300
        self.inScaleFactor = 0.007843
        self.meanVal       = 127.53
        self.classNames = ("background", "aeroplane", "bicycle", "bird", "boat",
                      "bouteille", "bus", "car", "cat", "chair",
                      "cow", "diningtable", "dog", "horse",
                      "motorbike", "person", "pottedplant",
                      "sheep", "sofa", "train", "tvmonitor")        

    def video(self):
        align_to = rs.stream.color
        align = rs.align(align_to)
        
        ######### wait auto focus
        for i in range(10):
            self.pipeline.wait_for_frames()
            
        while True:
            
            self.frameNb = self.frameNb + 1
            
            frames = self.pipeline.wait_for_frames()
            aligned_frames = align.process(frames)

            color_frame = aligned_frames.get_color_frame()
            depth_frame = aligned_frames.get_depth_frame()

            self.depth_frame = depth_frame

            color_image = np.asanyarray(color_frame.get_data())
            self.color_intrin = color_frame.profile.as_video_stream_profile().intrinsics

            # Convert depth_frame to numpy array to render image in opencv
            color_image = np.asanyarray(color_frame.get_data())
            color_cvt = cv2.cvtColor(color_image, cv2.COLOR_BGR2RGB)
#            self.show(color_cvt)

            self.img_copy = copy.copy(color_cvt)


            # Standard OpenCV boilerplate for running the net:
            height, width = self.img_copy.shape[:2]
            aspect = width / height
            resized_image = cv2.resize(self.img_copy, (round(self.expected * aspect), self.expected))
            crop_start = round(self.expected * (aspect - 1) / 2)
            crop_img = resized_image[0:self.expected, crop_start:crop_start+self.expected]

            blob = cv2.dnn.blobFromImage(crop_img, self.inScaleFactor, (self.expected, self.expected), self.meanVal, False)
            self.net.setInput(blob, "data")
            detections = self.net.forward("detection_out")

            label = detections[0,0,0,1]
            #conf  = detections[0,0,0,2]
            xmin  = detections[0,0,0,3]
            ymin  = detections[0,0,0,4]
            xmax  = detections[0,0,0,5]
            ymax  = detections[0,0,0,6]

            className = self.classNames[int(label)]

            cv2.rectangle(crop_img, (int(xmin * self.expected), int(ymin * self.expected)), 
                         (int(xmax * self.expected), int(ymax * self.expected)), (255, 255, 255), 2)
                         
            cv2.putText(crop_img, className, 
                (int(xmin * self.expected), int(ymin * self.expected) - 5),
                cv2.FONT_HERSHEY_COMPLEX, 0.5, (255,255,255))
                
            #self.sendMsg(className)
            
            # Render image in opencv window
            # cv2.imshow(self.title, self.img_copy)
            cv2.imshow(self.title, crop_img)
            titleNew = self.title + " frame:{0}".format(self.frameNb)
            cv2.setWindowTitle(self.title, titleNew)
            
            
            
            
            key = cv2.waitKey(10)
            if key & 0xFF == ord('q') or key == 27:
                cv2.destroyAllWindows()
                break

    def sendMsg(self,  objectName):
        print("--->" + objectName)
        
    def draw(self, event,x,y,flags,params):
         #print event,x,y,flags,params
        if(event==cv2.EVENT_LBUTTONDOWN):
            self.ix = x
            self.iy = y
            depth = self.get_depth_meter(x, y)
            print("start: depth {:0.2f} meter".format(depth), "@ ", x , y)
        elif event == cv2.EVENT_LBUTTONUP:
            depth = self.get_depth_meter(x, y)
            length=self.get_length_meter(x,y)
            print("end: depth {:0.2f} meter".format(depth), "length {:0.5} meter".format(length), "@ ", x , y)
            print() 
            self.img_work( x,y)
        elif event == cv2.EVENT_RBUTTONDOWN:
            print("à droite ^^")
        elif(flags==1):
            print("n'exite pas")
            

    def img_work(self, x,y):
        img = copy.copy(self.img_copy)
        
        font = cv2.FONT_HERSHEY_SIMPLEX
        fontScale = 1
        fontColor = (0, 0, 0)
        lineType = 2

        depth = self.get_depth_meter(x, y)
        #print("depth {:0.2f} meter".format(depth)) 
        length=self.get_length_meter(x,y)
        #print("length {:0.5} meter".format(length)) 
        
        if length > 0:
            cv2.line(img, pt1=(self.ix, self.iy), pt2=(x, y), color=(255, 255, 255), thickness=1)
            cv2.rectangle(img, (self.ix, self.iy), (self.ix + 80, self.iy - 20), (255, 255, 255), -1)            
            cv2.putText(img, '{0:.5}'.format(length), (self.ix, self.iy), font, fontScale, fontColor, lineType)
        else :    
            depth = self.get_depth_meter(x, y)
            cv2.line(img, pt1=(self.ix, self.iy), pt2=(x, y), color=(255, 255, 255), thickness=1)
            cv2.rectangle(img, (self.ix, self.iy), (self.ix + 80, self.iy - 20), (255, 255, 255), -1)     
            cv2.putText(img, '{:0.2f}'.format(depth), (self.ix, self.iy), font, fontScale, fontColor, lineType)       

    def get_depth_meter(self,x,y):
        ix,iy = self.ix, self.iy

        delta_x = 600 / self.expected
        delta_y = 480 / self.expected
        #print("-------------> deltax {:0.2f}, deltay {:0.2f}", delta_x , delta_y)
        
        ix = round(ix * delta_x)
        iy = round(iy * delta_y)
        #print("-------------> dx {:0.2f}, dy {:0.2f}dx, dy", ix , iy)
        
        depth = self.depth_frame.get_distance(ix,iy)
        print("-------------> start: depth {:0.2f} meter".format(depth), "@ ", ix , iy)
        return depth       

    def get_length_meter(self,x,y):
        color_intrin = self.color_intrin
        ix, iy = self.ix, self.iy
        udist = self.depth_frame.get_distance(ix, iy)
        vdist = self.depth_frame.get_distance(x, y)
        point1 = rs.rs2_deproject_pixel_to_point(color_intrin, [ix, iy], udist)
        point2 = rs.rs2_deproject_pixel_to_point(color_intrin, [x, y], vdist)
        length = math.sqrt(
            math.pow(point1[0] - point2[0], 2) + math.pow(point1[1] - point2[1],2) + math.pow(
                point1[2] - point2[2], 2))
        return length


if __name__ == '__main__':
    ARC().video()
