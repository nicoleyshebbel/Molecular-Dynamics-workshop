#!/bin/bash

# Exit on any error
set -e

# Run awk to add BENZ line at end of [ molecules ] section
awk '
/^\[ molecules \]/     { in_mol = 1; print; next }
/^\[/ && $0 != "[ molecules ]" {
    if (in_mol) {
        printf "%-15s%4d\n", "BENZ", 1
        in_mol = 0
    }
    print; next
}
{ print }
END {
    if (in_mol)
        printf "%-15s%4d\n", "BENZ", 1
}
' system.top > system.top.tmp && mv system.top.tmp system.top
