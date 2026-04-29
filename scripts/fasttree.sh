#!/bin/bash
set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate genome_qc

ROARY_DIR=${HOME}/SUPERCOMPUTING_final_project/output/roary_results/roary_output
OUT_DIR=${HOME}/SUPERCOMPUTING_final_project/output/phylogeny

mkdir -p "${OUT_DIR}"

FastTree -nt -gtr "${ROARY_DIR}/core_gene_alignment.aln" > "${OUT_DIR}/species_tree.tre"

conda deactivate
