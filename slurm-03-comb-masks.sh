#!/bin/bash
#SBATCH --job-name=yolo_singularity_run_YOLO
#SBATCH --output=./Data/slrum-batch-comb-masks/output_yolo_slrum-batch-comb-masks_%a.txt
#SBATCH --error=./Data/slrum-batch-comb-masks/error_yolo_slrum-batch-comb-masks_%a.txt
#SBATCH --ntasks=1
#SBATCH --mem=32gb
#SBATCH --time=01:00:00
#SBATCH --array=21-499

#f=$SLURM_ARRAY_TASK_ID

folder=$SLURM_ARRAY_TASK_ID

for video in {0..20}
do
	notebook_name=~/BC-actionpred-seg/05-yolo-comb-masks.ipynb
	outname=~/BC-actionpred-seg/Data/papermill-combmasks-v1/05-yolo-comb-masks-f${folder}-v${video}.ipynb

	echo $folder
	echo $video

	echo $notebook_name
	echo $outname

	papermill $notebook_name $outname -p folder $folder -p video $video --autosave-cell-every 5 --progress-bar
done