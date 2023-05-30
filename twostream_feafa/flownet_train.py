import torch
from torch.nn import functional as F
from torch import nn
from typing import Union
import numpy as np
from math import exp
import os
from os import listdir
from os.path import isfile, join
from torch.utils.data import Dataset, DataLoader
from PIL import Image
from torchvision import transforms
from torchvision import models
import torch.optim as optim
import gc

import feafa_utils
import feafa_dataloader
import feafa_architecture
import feafa_criterion


os.environ["CUDA_VISIBLE_DEVICES"]='0'

#path = "/mmfs1/data/anzellos/data/FEAFA2"
#path = '/data/aglinska/BC-actionpred-seg/Data/pytorch-data/action_data_orig/train/badminton_overswing'
path = '/data/aglinska/BC-actionpred-seg/Data/pytorch-data/xl_121_15_action_data_orig/train/'
window = 11
traindataset = feafa_dataloader.FeafaDataset(path,window,usage='Train')
trainloader = DataLoader(traindataset,batch_size = 32)
 
flownet = feafa_architecture.TinyMotionNet()
flownet.cuda()
flownet.train()

reconstructor = feafa_utils.Reconstructor()

criterion = feafa_criterion.SimpleLoss(flownet)

optimizer = optim.SGD(flownet.parameters(), lr=0.1, momentum=0.9)

#save_root = "/data/anzellos/results/twostream_feafa"
save_root = "/data/aglinska/BC-actionpred-seg/Data/02-results_twostream_feafa"

save_freq = 1                               # specify every how many epochs to save the model
loss_memory = []
for epoch in range(5):  # loop over the dataset multiple times
    print('Starting epoch ',epoch,' ...\n')
    running_loss = 0.0
    for i, data in enumerate(trainloader):
        # get the inputs
        frames = data['frames'].cuda()
        torch.cuda.empty_cache()
        flows = flownet(frames)
        t0s, reconstructed, flows_reshaped = reconstructor(frames, flows) # t0s are original images excluding the 11th, downsampled to match the reconstructed versions
        # zero the parameter gradients
        frames.detach().cpu()
        for flow in flows:
            flow.detach().cpu()
        del flows,frames
        gc.collect()
        torch.cuda.empty_cache()
        optimizer.zero_grad()
        # forward + backward + optimize
        loss = criterion(t0s,reconstructed,flows_reshaped,flownet)
        for t0 in t0s:
            t0.detach().cpu()
        for reco in reconstructed:
            reco.detach().cpu()
        for flore in flows_reshaped:
            flore.detach().cpu()
        del t0s,reconstructed,flows_reshaped
        gc.collect()
        torch.cuda.empty_cache()
        loss.backward()
        optimizer.step()
        # print statistics
        running_loss += loss.data.item()
    epoch_loss = running_loss / len(trainloader)
    print('[%d] loss: %.3f' %(epoch + 1, epoch_loss ))
    # loss_memory.append(epoch_loss)
    running_loss = 0.0
    if epoch % save_freq == save_freq-1: 
        savename = f'epoch{epoch+1:05d}.ckp'
        save_path = os.path.join(save_root,savename)
        torch.save({
            'epoch': epoch,
            'model_state_dict': flownet.state_dict(),
            'optimizer_state_dict': optimizer.state_dict(),
            'loss': epoch_loss
            }, save_path)


