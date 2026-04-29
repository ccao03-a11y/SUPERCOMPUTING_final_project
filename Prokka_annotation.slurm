#!/bin/bash
#SBATCH --job-name=Prokka_Ecoli_Annotation
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8          # CPU cores requested
#SBATCH --mem=16G                  # Memory requested
#SBATCH --time=06:00:00            # Walltime (6 hours is plenty for annotation)
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=ccao03@wm.edu
#SBATCH -o /sciclone/home/ccao03/SUPERCOMPUTING_final_project/log/prokka_run_%j.out
#SBATCH -e /sciclone/home/ccao03/SUPERCOMPUTING_final_project/log/prokka_run_%j.err

./scripts/04_prokka_annotation.sh
