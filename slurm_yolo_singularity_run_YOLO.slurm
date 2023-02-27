#!/bin/bash
#SBATCH --job-name=yolo_singularity_run_YOLO
#SBATCH --output=./Data/slurm-batch-run-YOLO/output_yolo_singularity_run_YOLO_%a.txt
#SBATCH --error=./Data/slurm-batch-run-YOLO/error_yolo_singularity_run_YOLO_%a.txt
#SBATCH --ntasks=1
#SBATCH --mem=32gb
#SBATCH --time=04:00:00
#SBATCH --array=0-500

f=$SLURM_ARRAY_TASK_ID
echo $f


bash
module load singularity

singularity exec ~/yolov8.sif python ~/BC-actionpred-seg/for_yolo_singularity_make_masks_slurm.py $f

echo 'all done'





