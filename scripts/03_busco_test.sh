#!/bin/bash

set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate genome_qc

DATA_DIR=${HOME}/SUPERCOMPUTING_final_project/data
OUTPUT_DIR=${HOME}/SUPERCOMPUTING_final_project/output
OUT_DIR=${OUTPUT_DIR}/busco_results
ASSEMBLY_DIR=${OUTPUT_DIR}/assembly
REPORT_FILE=${OUTPUT_DIR}/busco_summary.md

mkdir -p "${OUT_DIR}"

for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2)
do
sample_fasta="${ASSEMBLY_DIR}/${i}_assembled/scaffolds.fasta"
if [ -f "$sample_fasta" ]; then
busco -i "${sample_fasta}" -o "${i}" -l enterobacterales_odb10 -m genome -c 8 --out_path "${OUT_DIR}" --force
else
echo "cannot find $sample_fasta"
fi
done

echo "| Sample ID | Complete (C) | Single (S) | Duplicated (D) | Fragmented (F) | Missing (M) |" > "${REPORT_FILE}"
echo "| :--- | :---: | :---: | :---: | :---: | :---: |" >> "${REPORT_FILE}"

for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2)
do

BUSCO_FILE=$(find "${OUT_DIR}/${i}" -name "short_summary.specific.*.txt" | head -n 1)
if [ -f "$BUSCO_FILE" ]; then
COMP=$(grep -o "C:[0-9.]*%" "$BUSCO_FILE" | cut -d':' -f2)
SING=$(grep -o "S:[0-9.]*%" "$BUSCO_FILE" | cut -d':' -f2)
DUPL=$(grep -o "D:[0-9.]*%" "$BUSCO_FILE" | cut -d':' -f2)
FRAG=$(grep -o "F:[0-9.]*%" "$BUSCO_FILE" | cut -d':' -f2)
MISS=$(grep -o "M:[0-9.]*%" "$BUSCO_FILE" | cut -d':' -f2)
echo "| **${i}** | ${COMP} | ${SING} | ${DUPL} | ${FRAG} | ${MISS} |" >> "${REPORT_FILE}"
else
echo "| **${i}** | N/A | N/A | N/A | N/A | N/A |" >> "${REPORT_FILE}"
fi
done

conda deactivate
