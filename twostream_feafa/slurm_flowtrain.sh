#!/bin/bash
#SBATCH --job-name=flowtrain    # Job name
#SBATCH --ntasks=1 
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-node=1
#SBATCH --mem=32gb                     # Job memory request
#SBATCH --partition=anzellos
#SBATCH --time=36:00:00               # Time limit hrs:min:sec
#SBATCH --output=slurm_flowtrain_output.txt
#SBATCH --error=slurm_flowtrain_error.txt

module load cuda10.2/toolkit/10.2.89
module load pytorch/1.7.0gpu.cuda10.2

cd ~/BC-actionpred-seg/twostream_feafa/
pwd; hostname; date

python flownet_train.py
#python /mmfs1/data/anzellos/code/twostream_feafa/flownet_train.py

echo "all done"
date

