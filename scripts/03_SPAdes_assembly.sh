#!/bin/bash

set -euo pipefail

DATA_DIR=${HOME}/SUPERCOMPUTING_final_project/data
CLEAN_DIR=${DATA_DIR}/clean
ASSEMBLY_DIR=${HOME}/SUPERCOMPUTING_final_project/output/assembly
mkdir -p "${ASSEMBLY_DIR}"

for i in $(cut -d ',' -f1 ${DATA_DIR}/SraRunTable.csv | tail -n +2 | tr -d '\r')
do
spades.py -1 "${CLEAN_DIR}/${i}_1.trimmed.fastq.gz" -2 "${CLEAN_DIR}/${i}_2.trimmed.fastq.gz" --isolate -k 33,55,77 --cov-cutoff 5 --only-assembler -o "${ASSEMBLY_DIR}/${i}_assembled"
done
