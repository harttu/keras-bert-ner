echo \#!/bin/bash
echo \#SBATCH --nodes=1
echo \#SBATCH --ntasks=1
echo \#SBATCH --cpus-per-task=1
echo \#SBATCH --mem=$2
echo \#SBATCH -p $1
echo \#SBATCH -t $3
echo \#SBATCH --gres=gpu:v100:1
echo \#SBATCH --ntasks-per-node=1
echo \#SBATCH --account=Project_2001426
echo \#SBATCH -o JOBGEN/runs/$4/%j.out
echo \#SBATCH -e JOBGEN/runs logs/$4/%j.err

