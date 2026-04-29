#!/bin/bash
#SBATCH --job-name=spades
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=2-00:00:00
#SBATCH --mem=25G
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=ccao03@wm.edu
#SBATCH -o /sciclone/home/ccao03/SUPERCOMPUTING_final_project/log/spades_%j.out
#SBATCH -e /sciclone/home/ccao03/SUPERCOMPUTING_final_project/log/spades_%j.err

set -euo pipefail

export PATH=$PATH:/sciclone/home/ccao03/programs/SPAdes-4.2.0-Linux/bin

./scripts/03_SPAdes_assembly.sh
