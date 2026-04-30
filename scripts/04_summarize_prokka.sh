#!/bin/bash

OUT_DIR=${HOME}/SUPERCOMPUTING_final_project/output
PROKKA_DIR=${OUT_DIR}/annotation

# 1. Create headers
echo "Sample" > names.tmp
echo "Contigs" > contigs.tmp
echo "Bases" > bases.tmp
echo "CDS" > cds.tmp
echo "misc_RNA" > mRNA.tmp
echo "Repeat_Region" > rr.tmp
echo "tRNA" > tRNA.tmp
echo "tmRNA" > tmRNA.tmp

# 2. Extract data from each .txt file
for f in ${PROKKA_DIR}/*_prokka/*.txt; do
basename $f .txt >> names.tmp

grep "contigs:" $f | awk '{print $2}' | sed 's/^$/0/' >> contigs.tmp
grep "bases:" $f | awk '{print $2}' | sed 's/^$/0/' >> bases.tmp
grep "CDS:" $f | awk '{print $2}' | sed 's/^$/0/' >> cds.tmp
grep "misc_RNA:" $f | awk '{print $2}' | sed 's/^$/0/' >> mRNA.tmp

[[ $(grep "repeat_region:" $f) ]] && grep "repeat_region:" $f | awk '{print $2}' >> rr.tmp || echo "0" >> rr.tmp
[[ $(grep "tRNA:" $f) ]] && grep "tRNA:" $f | awk '{print $2}' >> tRNA.tmp || echo "0" >> tRNA.tmp
[[ $(grep "tmRNA:" $f) ]] && grep "tmRNA:" $f | awk '{print $2}' >> tmRNA.tmp || echo "0" >> tmRNA.tmp
done

# 3. Use 'paste' to join columns and format as a table
paste names.tmp contigs.tmp bases.tmp cds.tmp mRNA.tmp rr.tmp tRNA.tmp tmRNA.tmp | column -t > ${OUT_DIR}/annotation_comparison.txt

# 4. Clean up temporary files
rm *.tmp

