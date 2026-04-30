#!/bin/bash

set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate genome_qc

DATA_DIR=${HOME}/SUPERCOMPUTING_final_project/data
OUTPUT_DIR=${HOME}/SUPERCOMPUTING_final_project/output
OUT_DIR=${OUTPUT_DIR}/quast_results
ASSEMBLY_DIR=${OUTPUT_DIR}/assembly
mkdir -p ${OUT_DIR}

for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2)
do
sample_fasta="${ASSEMBLY_DIR}/${i}_assembled/scaffolds.fasta"

if [ -f "$sample_fasta" ] ; then
quast.py "${sample_fasta}" -o "${OUT_DIR}/${i}" -t 8 --labels "${i}"
else
echo "cannot find $sample_fasta"
fi
done

# comparison
quast.py ${ASSEMBLY_DIR}/*_assembled/scaffolds.fasta -o "${OUT_DIR}/combined_comparison" -t 8

conda deactivate
