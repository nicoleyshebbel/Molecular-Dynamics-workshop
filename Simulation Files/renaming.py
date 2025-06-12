# rename.py
import sys

#---------------
# python rename.py input.pdb output.pdb
#---------------


# Define new atom names
atom_name_map = [
    "CA", "CB", "CG", "CD", "CE", "CF",
    "CG1", "CG2", "CD1", "CD2", "CE1", "CE2"
]

def rename_atoms(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    renamed_lines = []
    current_residue = None
    atom_index = 0

    for line in lines:
        if not line.startswith("ATOM"):
            renamed_lines.append(line)
            continue

        res_id = line[22:26]
        if res_id != current_residue:
            current_residue = res_id
            atom_index = 0

        new_name = atom_name_map[atom_index % len(atom_name_map)].ljust(4)
        new_line = line[:12] + new_name + line[16:]
        renamed_lines.append(new_line)
        atom_index += 1

    with open(output_file, 'w') as f:
        f.writelines(renamed_lines)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python rename.py input.pdb output.pdb")
        sys.exit(1)

    input_pdb = sys.argv[1]
    output_pdb = sys.argv[2]
    rename_atoms(input_pdb, output_pdb)
    print("Sometimes life is like this tunnel. You can’t always see the light at the end of the tunnel, but if you keep moving, you will come to a better place. —Iroh")
