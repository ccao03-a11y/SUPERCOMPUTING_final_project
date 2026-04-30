#!/bin/bash
set -euo pipefail

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate genome_qc

ROARY_DIR="${HOME}/SUPERCOMPUTING_final_project/output/roary_results/roary_output"

if [ ! -d "$ROARY_DIR" ]; then
echo "cannot find $ROARY_DIR"
exit 1
fi

cd "$ROARY_DIR"

if [ ! -f "core_gene_alignment.aln" ]; then
echo "cannot find core_gene_alignment.aln"
exit 1
fi

snp-sites -m -o core_snps.fasta core_gene_alignment.aln

FastTree -nt -gtr< core_snps.fasta > snp_based_tree.tre

conda deactivate
