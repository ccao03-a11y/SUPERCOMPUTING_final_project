#!/bin/bash
#SBATCH --job-name=BUSCO_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=ccao03@wm.edu
#SBATCH --time=05:00:00
#SBATCH -o /sciclone/home/ccao03/SUPERCOMPUTING_final_project/log/busco_test_%j.log
#SBATCH -e /sciclone/home/ccao03/SUPERCOMPUTING_final_project/log/busco_test_%j.err

./scripts/busco_test.sh
