#!/bin/bash

set -euo pipefail

DATA_DIR=${HOME}/SUPERCOMPUTING_final_project/data
RAW_DIR=${DATA_DIR}/raw
CLEAN_DIR=${DATA_DIR}/clean
mkdir -p $CLEAN_DIR

# apply fastp
for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2)
do
FWD_IN="${RAW_DIR}/${i}_1.fastq.gz"
REV_IN="${RAW_DIR}/${i}_2.fastq.gz"
FWD_OUT="${CLEAN_DIR}/${i}_1.trimmed.fastq.gz"
REV_OUT="${CLEAN_DIR}/${i}_2.trimmed.fastq.gz"
fastp -i "${FWD_IN}" -I "${REV_IN}" -o "${FWD_OUT}" -O "${REV_OUT}" --json /dev/null --html log/$(basename "$FWD_IN") --n_base_limit 0 --qualified_quality_phred 20 --length_required 75
done
