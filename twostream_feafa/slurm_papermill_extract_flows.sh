#!/bin/bash
#SBATCH --job-name=extract_flows_papermill
#SBATCH --output=slurm_papermill_extract_output.txt
#SBATCH --error=slurm_papermill_extract_error.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gpus-per-node=1
#SBATCH --time=24:00:00
#SBATCH --mem=64gb
#SBATCH --partition=anzellos


bash
#module load tensorflow/2.3.1gpu
module load pytorch/1.7.0gpu.cuda10.2

notebook_name='03-extract-flows.ipynb'
outname='03-extract-flows-papermill-1.ipynb'

papermill $notebook_name $outname --autosave-cell-every 5 --progress-bar

