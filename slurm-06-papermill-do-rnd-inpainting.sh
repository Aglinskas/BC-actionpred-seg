#!/bin/bash
#SBATCH --job-name=do_rnd_inpainting
#SBATCH --output=./Data/dataset-v1-slurm/output_rnd_inpainting_%a.txt
#SBATCH --error=./Data/dataset-v1-slurm/error_rnd_inpainting_%a.txt
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH --time=01:00:00
#SBATCH --array=0-1522

#f=$SLURM_ARRAY_TASK_ID


i=$SLURM_ARRAY_TASK_ID
notebook_name=09-make-dataset-v1.ipynb
outname=./Data/dataset-v1-papermill/09-inpaint-rnd-$i.ipynb

echo $i
echo $notebook_name
echo $outname

papermill $notebook_name $outname --autosave-cell-every 5 --progress-bar -p i $i


