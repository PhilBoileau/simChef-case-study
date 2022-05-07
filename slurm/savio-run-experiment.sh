#!/bin/bash
# Job name:
#SBATCH --job-name=run-sim-chef-case-study
#
# Account:
#SBATCH --account=co_biostat
#
# Quality of Service:
#SBATCH --qos=biostat_savio3_normal
#
# Partition:
#SBATCH --partition=savio3
#
# Processors (1 node = 40 cores):
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --exclusive
#
# Wall clock limit ('0' for unlimited):
#SBATCH --time=24:00:00
#
# Mail type:
#SBATCH --mail-type=all
#
# Mail user:
#SBATCH --mail-user=philippe_boileau@berkeley.edu
#
# Job output:
#SBATCH --output=slurm.out
#SBATCH --error=slurm.out
#
## Command(s) to run:
export R_LIBS_USER='/global/scratch/users/philippe_boileau/R'
export TMPDIR='~/rtmp'  # resolve update issues for compiled packages
module load r/4.0.3 r-packages/default
cd ~/simChef-case-study

R CMD BATCH --no-save --no-restore \
  R/meal.R \
  logs/savio-run-experiment.Rout
