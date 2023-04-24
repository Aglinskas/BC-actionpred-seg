#!/bin/bash
#SBATCH --job-name=papermill-split-frames
#SBATCH --output=./Data/papermill-split-into-frames/output_papermill-split-frames_%a.txt
#SBATCH --error=./Data/papermill-split-into-frames/error_papermill-split-frames_%a.txt
#SBATCH --ntasks=1
#SBATCH --mem=4gb
#SBATCH --time=01:00:00
#SBATCH --array=0-500


f=$SLURM_ARRAY_TASK_ID
notebook_name=~/BC-actionpred-seg/03-spit-into-frames.ipynb
outname=~/BC-actionpred-seg/Data/papermill-split-into-frames/03-spit-into-frames-${f}.ipynb

echo $f
echo $notebook_name
echo $outname


papermill $notebook_name $outname --autosave-cell-every 5 --progress-bar -p f $f 









