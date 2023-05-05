#!/bin/bash
#SBATCH --job-name=train_xl
#SBATCH --output=train_xl_output.txt
#SBATCH --error=train_xl_error.txt
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH --gpus-per-node=1
#SBATCH --partition=anzellos
#SBATCH --time=48:00:00


notebook_name=11-resnet50-train-xl.ipynb
outname=11-resnet50-train-xl-run2.ipynb

papermill $notebook_name $outname --autosave-cell-every 60


