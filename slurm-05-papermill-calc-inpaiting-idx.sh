#!/bin/bash
#SBATCH --job-name=papermill-calc-inpainting-idx
#SBATCH --output=./Data/output_papermill-calc-inpainting-idx.txt
#SBATCH --error=./Data/error_papermill-calc-inpainting-idx.txt
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH --time=120:00:00


notebook_name=~/BC-actionpred-seg/08-calc-inpainting-idx-small.ipynb
outname=~/BC-actionpred-seg/081-calc-inpainting-idx-small-papermill.ipynb

#notebook_name=~/BC-actionpred-seg/08-calc-inpainting-idx.ipynb
#outname=~/BC-actionpred-seg/081-calc-inpainting-idx-papermill.ipynb

echo $notebook_name
echo $outname


papermill $notebook_name $outname --autosave-cell-every 5 --progress-bar









