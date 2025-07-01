#!/bin/bash

# Exit on any error
set -e
awk '
  { lines[NR] = $0 }
  END {
    for (i=1; i < NR; i++) print lines[i]
    printf " 1BENZ       R1    1   3.092   0.660   2.416\n"
    printf " 1BENZ       R2    2   2.882   0.500   2.361\n"
    printf " 1BENZ       R3    3   2.986   0.658   2.168\n"
    print lines[NR]
  }
' protein_ligand.gro > tmp && mv tmp protein_ligand.gro
