#!/bin/bash

set -euo pipefail


DATA_DIR=${HOME}/SUPERCOMPUTING_final_project/data
OUT_DIR=${DATA_DIR}/raw
mkdir -p $OUT_DIR

for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2); do fasterq-dump -O "${OUT_DIR}" "$i"; done
gzip ${OUT_DIR}/*
