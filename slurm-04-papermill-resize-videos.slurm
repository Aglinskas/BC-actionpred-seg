#!/bin/bash
#SBATCH --job-name=papermill-resize-videos
#SBATCH --output=./Data/papermill-resize-videos/output_papermill-resize-videos_%a.txt
#SBATCH --error=./Data/papermill-resize-videos/error_papermill-resize-videos_%a.txt
#SBATCH --ntasks=1
#SBATCH --mem=4gb
#SBATCH --time=01:00:00
#SBATCH --array=0-500


f=$SLURM_ARRAY_TASK_ID

notebook_name=~/BC-actionpred-seg/06-resize-videos.ipynb
outname=~/BC-actionpred-seg/Data/papermill-resize-videos/06-resize-videos-${f}.ipynb

echo $f
echo $notebook_name
echo $outname


papermill $notebook_name $outname --autosave-cell-every 5 --progress-bar -p f $f 









