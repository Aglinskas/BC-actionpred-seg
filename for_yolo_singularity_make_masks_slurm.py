import numpy as np
from ultralytics import YOLO
from matplotlib import pyplot as plt
import os
import sys

f = sys.argv[-1]
f = int(f)

model = YOLO("yolov8x-seg.pt")
#model = YOLO("yolov8n-seg.pt")

indir = '~/BC-actionpred-seg/Data/haa500_v1_1_frames/video/' 
indir = os.path.expanduser(indir)

folders = [folder for folder in os.listdir(indir) if not folder.startswith('.')]
folders.sort()

videos = []
for folder in folders:
    conts = os.listdir(os.path.join(indir,folder))
    conts = [os.path.join(indir,folder,cont) for cont in conts if not cont.startswith('.')]
    conts.sort()
    videos.append(conts)

for v in range(20):
    frames = [os.path.join(videos[f][v],frame) for frame in os.listdir(videos[f][v]) if frame.endswith('.png')]
    frames.sort()

    print(videos[f][v])

    for infn in frames:

        try:
            results = model.predict(infn)

            box = np.array(results[0].boxes.boxes)
            box.shape
            np.save(infn.replace('.png','_box.npy'),box)

            arr = np.array(results[0].masks.masks)
            np.save(infn.replace('.png','_masks.npy'),arr)
        except:
            print('passing')
    print('done')

