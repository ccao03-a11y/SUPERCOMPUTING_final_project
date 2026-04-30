#!/bin/bash
set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate pangenome

OUTPUT_DIR=${HOME}/SUPERCOMPUTING_final_project/output
PROKKA_DIR=${OUTPUT_DIR}/annotation
OUT_DIR=${OUTPUT_DIR}/roary_results

mkdir -p "${OUT_DIR}"

TEMP_GFF_DIR="${OUT_DIR}/temp_gffs"
mkdir -p "${TEMP_GFF_DIR}"

cp ${PROKKA_DIR}/*/*.gff "${TEMP_GFF_DIR}/"

cd "${OUT_DIR}"

roary  -e --mafft -p 8 -f "${OUT_DIR}/roary_output" -v "${TEMP_GFF_DIR}"/*.gff

rm -rf "${TEMP_GFF_DIR}"

conda deactivate
