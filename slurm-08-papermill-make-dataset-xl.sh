#!/bin/bash
#SBATCH --job-name=make_xl_dataset_bg
#SBATCH --output=./Data/make_xl_dataset_output_bg.txt
#SBATCH --error=./Data/make_xl_dataset_error_bg.txt
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH --time=72:00:00


notebook_name=10-resnet-50-make-data-xl.ipynb
outname=10-resnet-50-make-data-xl-pp-bg.ipynb

# papermill $notebook_name $outname --autosave-cell-every 60 -p 'outdir' './Data/pytorch-data/xl_280_10_action_data_orig' -p 'fn_temp' './Data/haa500_v1_1_yolo_seg4/{c}/{c}_{v:03d}.mp4'
# papermill $notebook_name $outname --autosave-cell-every 60 -p 'outdir' './Data/pytorch-data/xl_280_10_action_data_seg' -p 'fn_temp' './Data/haa500_v1_1_yolo_seg4/{c}/{c}_{v:03d}_item_0_fwd_seg.mp4'
papermill $notebook_name $outname --autosave-cell-every 60 -p 'outdir' './Data/pytorch-data/xl_280_10_action_data_bg' -p 'fn_temp' './Data/haa500_v1_1_yolo_seg4/{c}/{c}_{v:03d}_item_0_inp_seg.mp4'


