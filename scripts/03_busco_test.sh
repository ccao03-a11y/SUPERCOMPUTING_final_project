#!/bin/bash

set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate genome_qc

DATA_DIR=${HOME}/SUPERCOMPUTING_final_project/data
OUTPUT_DIR=${HOME}/SUPERCOMPUTING_final_project/output
OUT_DIR=${OUTPUT_DIR}/busco_results
ASSEMBLY_DIR=${OUTPUT_DIR}/assembly

mkdir -p "${OUT_DIR}"

for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2)
do
sample_fasta="${ASSEMBLY_DIR}/${i}_assembled/scaffolds.fasta"
if [ -f "$sample_fasta" ]; then
busco -i "${sample_fasta}" -o "${i}" -l enterobacterales_odb10 -m genome -c 8 --out_path "${OUT_DIR}"  --force
else
echo "cannot find $sample_fasta"
fi
done

conda deactivate
