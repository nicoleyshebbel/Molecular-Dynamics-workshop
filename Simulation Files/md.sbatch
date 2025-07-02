#!/bin/bash
#SBATCH --job-name=short_md
#SBATCH --output=output_short_md_%j.log
#SBATCH --error=error_short_md_%j.log
#SBATCH --partition=gpu-short
#SBATCH --gres=gpu:2080_ti:4
#SBATCH --ntasks=4
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=6
#SBATCH --mem=100G
#SBATCH --time=04:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=user@email.com


module load GROMACS/2024.4-foss-2023b-CUDA-12.4.0-PLUMED-2.9.2

echo "## Starting GPU test on $HOSTNAME"
TEST_DIR=$(pwd)
echo "## Current directory $TEST_DIR"
echo "## Number of available CUDA devices: $(nvidia-smi -L | wc -l)"
echo "## Checking status of CUDA device with nvidia-smi"
nvidia-smi
export GMX_GPU_DD_COMMS=true
export GMX_GPU_PME_PP_COMMS=true


gmx mdrun -deffnm dynamic -v -ntmpi 4  -ntomp ${SLURM_CPUS_PER_TASK:-1} -pin on
