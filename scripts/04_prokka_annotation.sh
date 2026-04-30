#!/bin/bash
set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate prokka

set -euo pipefail

DATA_DIR="${HOME}/SUPERCOMPUTING_final_project/data"
OUT_DIR="${HOME}/SUPERCOMPUTING_final_project/output"
ASSEMBLY_DIR="${OUT_DIR}/assembly"
ANNOTATION_DIR="${OUT_DIR}/annotation"
mkdir -p "${ANNOTATION_DIR}"

# check if the assembly file actually exits before running
for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2 | tr -d '\r')
do
INPUT_FILE="${ASSEMBLY_DIR}/${i}_assembled/contigs.fasta"
SAMPLE_OUT="${ANNOTATION_DIR}/${i}_prokka"
if [ ! -f "$INPUT_FILE" ]; then echo "Error: $INPUT_FILE was not found. Skipping sample $i."
continue
fi

# run Prokka (strict settings)
prokka --outdir "$SAMPLE_OUT"  --prefix "${i}" --genus Escherichia --species coli --strain "${i}" --mincontiglen 1000 --rfam --cpus 8 --force "$INPUT_FILE"
done

conda deactivate
