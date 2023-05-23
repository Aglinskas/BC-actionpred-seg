#!/bin/bash
#SBATCH --job-name=flowtrain    # Job name
#SBATCH --mail-type=BEGIN,END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=anzellos@bc.edu     # Where to send mail	
#SBATCH --ntasks=1 --cpus-per-task=1
#SBATCH --mem=32gb                     # Job memory request
#SBATCH --partition=anzellos
#SBATCH --time=36:00:00               # Time limit hrs:min:sec
#SBATCH --output=flowtrain_%j.log   # Standard output and error log

module load cuda10.2/toolkit/10.2.89
module load pytorch/1.7.0gpu

python /mmfs1/data/anzellos/code/twostream_feafa/flownet_train.py

pwd; hostname; date
