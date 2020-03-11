import cv2
import time
import numpy as np
import csv
import os
import urllib.request
from PIL import Image
from flask import Flask, request
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

#  Used to get patient image using URL
#  url = 'http://www.example.com/my_image_is_not_your_image.png'
#  img = Image.open(urllib.request.urlopen(url))
class ImageComparison(Resource):
    def post(self):
        try:
            MODE = "MPI"

            if MODE=="COCO":
                protoFile = "OpenPose/pose/coco/pose_deploy_linevec.prototxt"
                weightsFile = "OpenPose/pose/coco/pose_iter_440000.caffemodel"
                nPoints = 18
                POSE_PAIRS = [ [1,0],[1,2],[1,5],[2,3],[3,4],[5,6],[6,7],[1,8],[8,9],[9,10],[1,11],[11,12],[12,13],[0,14],[0,15],[14,16],[15,17]]

            elif MODE=="MPI" :
                protoFile = "OpenPose/pose/mpi/pose_deploy_linevec_faster_4_stages.prototxt"
                weightsFile = "OpenPose/pose/mpi/pose_iter_160000.caffemodel"
                nPoints = 15
                POSE_PAIRS = [[0,1], [1,2], [2,3], [3,4], [1,5], [5,6], [6,7], [1,14], [14,8], [8,9], [9,10], [14,11], [11,12], [12,13] ]

            pictures = ['Warrior One.jpg','Cat Pose.jpg','Chair Pose.jpg','Cow Pose.jpg']
            # return request.data
            print(1)
            fromJson = request.form['index']
            print(fromJson)
            # return str(fromJson)
            index = int(fromJson)

            frame = cv2.imread(pictures[index])

            frameCopy = np.copy(frame)
            frame1 = np.copy(frame)

            for i in range(len(frameCopy)):
                    for j in range(len(frameCopy[0])):
                            frameCopy[i][j]=0
                            frame1[i][j]=0
                    
            frameWidth = frame.shape[1]
            frameHeight = frame.shape[0]
            threshold = 0.1
            net = cv2.dnn.readNetFromCaffe(protoFile, weightsFile)

            t = time.time()
            # input image dimensions for the network
            inWidth = 368
            inHeight = 368
            inpBlob = cv2.dnn.blobFromImage(frame, 1.0 / 255, (inWidth, inHeight),
                                    (0, 0, 0), swapRB=False, crop=False)

            net.setInput(inpBlob)

            output = net.forward()
            # print("time taken by network : {:.3f}".format(time.time() - t))

            H = output.shape[2]
            W = output.shape[3]

            # Empty list to store the detected keypoints
            pointsdoc = []
            valuesdoc=[]

            # with open('doccoordinates.csv', 'w', newline='') as file:
                # writer = csv.writer(file)
                # writer.writerow(["X", "Y", "Part"])
                
            for i in range(nPoints):
                # confidence map of corresponding body's part.
                probMap = output[0, i, :, :]

                    # Find global maxima of the probMap.
                minVal, prob, minLoc, point = cv2.minMaxLoc(probMap)
                    
                    # Scale the point to fit on the original image
                x = (frameWidth * point[0]) / W
                y = (frameHeight * point[1]) / H

                if prob > threshold : 
                    cv2.circle(frameCopy, (int(x), int(y)), 8, (255, 0, 0), thickness=-1, lineType=cv2.FILLED)
                    cv2.putText(frameCopy, "{}".format(i), (int(x), int(y)), cv2.FONT_HERSHEY_SIMPLEX, 0.5 , (255, 255, 255), 2, lineType=cv2.LINE_AA)

                        # Add the point to the list if the probability is greater than the threshold
                    pointsdoc.append((int(x), int(y)))
                    # print(x,y,i)
                    valuesdoc.append([round(x), round(y), i])
                else :
                    pointsdoc.append(None)    

            

            # Draw Skeleton
            for pair in POSE_PAIRS:
                partA = pair[0]
                partB = pair[1]
                
                if pointsdoc[partA] and pointsdoc[partB]:
                    cv2.line(frameCopy, pointsdoc[partA], pointsdoc[partB], (0, 255, 255), 2)

            cv2.imwrite('docpicskel.jpg', frameCopy)



            img = Image.open("docpicskel.jpg")
            redwidth, redheight = img.size
            # print(redwidth,redheight)
            dim=(redwidth,redheight)

            MODE = "MPI"

            if MODE=="COCO":
                protoFile = "OpenPose/pose/coco/pose_deploy_linevec.prototxt"
                weightsFile = "OpenPose/pose/coco/pose_iter_440000.caffemodel"
                nPoints = 18
                POSE_PAIRS = [ [1,0],[1,2],[1,5],[2,3],[3,4],[5,6],[6,7],[1,8],[8,9],[9,10],[1,11],[11,12],[12,13],[0,14],[0,15],[14,16],[15,17]]

            elif MODE=="MPI" :
                protoFile = "OpenPose/pose/mpi/pose_deploy_linevec_faster_4_stages.prototxt"
                weightsFile = "OpenPose/pose/mpi/pose_iter_160000.caffemodel"
                nPoints = 15
                POSE_PAIRS = [[0,1], [1,2], [2,3], [3,4], [1,5], [5,6], [6,7], [1,14], [14,8], [8,9], [9,10], [14,11], [11,12], [12,13] ]
            

            # url = fromJson['url']
            # resp = urllib.request.urlopen(url)
            # image = np.asarray(int(request.files["file"]), dtype="uint8")
            print(3)
            Img = request.files['file']
            print(4)
            Img.save("user.jpg")      
            # image = cv2.imdecode(image, cv2.IMREAD_COLOR)
            # image = cv2.imdecode(cv2.UMat(request.files["file"]),cv2.IMREAD_COLOR)
            
            frame = cv2.imread("user.jpg")

            frame = cv2.resize(frame, dim, interpolation = cv2.INTER_AREA)

            frameCopy = np.copy(frame)
            frame1 = np.copy(frame)

            patientcoordinates = []
            parts=["Head","Neck","Right Shoulder","Right Elbow","Right Wrist","Left Shoulder","Left Elbow","Left Wrist","Right Hip","Right Knee","Right Ankle","Left Hip","Left Knee","Left Ankle","Chest"]

            for i in range(len(frameCopy)):
                    for j in range(len(frameCopy[0])):
                            frameCopy[i][j]=0
                            frame1[i][j]=0
                    
            frameWidth = frame.shape[1]
            frameHeight = frame.shape[0]
            threshold = 0.1

            net = cv2.dnn.readNetFromCaffe(protoFile, weightsFile)

            t = time.time()
            # input image dimensions for the network
            inWidth = 368
            inHeight = 368
            inpBlob = cv2.dnn.blobFromImage(frame, 1.0 / 255, (inWidth, inHeight),
                                    (0, 0, 0), swapRB=False, crop=False)

            net.setInput(inpBlob)

            output = net.forward()
            print("time taken by network : {:.3f}".format(time.time() - t))

            H = output.shape[2]
            W = output.shape[3]

            # Empty list to store the detected keypoints
            points = []

            with open('patientcoordinates.csv', 'w', newline='') as file:
                writer = csv.writer(file)
                # writer.writerow(["X", "Y", "Part"])

                for i in range(nPoints):
                    # confidence map of corresponding body's part.
                    probMap = output[0, i, :, :]

                    # Find global maxima of the probMap.
                    minVal, prob, minLoc, point = cv2.minMaxLoc(probMap)
                    
                    # Scale the point to fit on the original image
                    x = (frameWidth * point[0]) / W
                    y = (frameHeight * point[1]) / H

                    if prob > threshold : 
                        cv2.circle(frameCopy, (int(x), int(y)), 8, (255, 0, 0), thickness=-1, lineType=cv2.FILLED)
                        cv2.putText(frameCopy, "{}".format(i), (int(x), int(y)), cv2.FONT_HERSHEY_SIMPLEX, 0.5 , (255, 255, 255), 2, lineType=cv2.LINE_AA)
                        # Add the point to the list if the probability is greater than the threshold
                        points.append((int(x), int(y)))
                        # print(x,y,i)
                        writer.writerow([round(x), round(y), i])
                        patientcoordinates.append((int(x),int(y),int(i)))
                    else :
                        points.append(None)
            print(patientcoordinates)

            # Draw Skeleton

            for pair in POSE_PAIRS:
                partA = pair[0]
                partB = pair[1]
                
                if points[partA] and points[partB]:
                    cv2.line(frameCopy, points[partA], points[partB], (0, 255, 255), 2)



            cv2.imshow('Output-Keypoints', frameCopy)
            cv2.imwrite('Output-Keypoints.jpg', frameCopy)

            im1 = Image.open(r"Output-Keypoints.jpg")
            patientpicskel=im1.save("patientpicskel.jpg")

            print("Total time taken : {:.3f}".format(time.time() - t))
            j=0
            result=[]
            c = 0
            with open('doccoordinates.csv', 'r') as file:
                reader = csv.reader(file)
                for i in reader:
                    if j<=14 and j == patientcoordinates[c][2]:
                        print(patientcoordinates[c] , j , c)
                        if(abs(int(i[0])-patientcoordinates[c][0])>=10 or abs(int(i[1])-patientcoordinates[c][1]>=10)):
                            result.append(parts[j])
                        c += 1
                    j+=1
                    
            
            if len(result)!=0:
                return {'result' : result}
            else:
                return {'result' : ['No Error']}
        
        except Exception as e:
            items = [str(i) for i in request.form.lists()]
            return {
                "exception" : str(e),
                "items" : items
            }

api.add_resource(ImageComparison,'/')

if __name__ == '__main__':
    app.run(debug=True)
