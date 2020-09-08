#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH -p gpu
#SBATCH -t 00:30:00
#SBATCH --gres=gpu:v100:1
#SBATCH --ntasks-per-node=1
#SBATCH --account=Project_2001426
#SBATCH -o runs/a16/%j.out
#SBATCH -e runs/a16/%j.out

#rm -f logs/latest.out logs/latest.err
#ln -s $SLURM_JOBID.out logs/latest.out
#ln -s $SLURM_JOBID.err logs/latest.err

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 SCRIPT [ARG[...]]" >&2
    exit 1
fi

script=$1
shift

module purge
module load tensorflow
#module load python-data
#source $HOME/venv/keras-bert/bin/activate
source venv/bin/activate

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

echo "START $SLURM_JOBID ($script): $(date)"

srun "$script" "$@"

echo "END $SLURM_JOBID ($script): $(date)"

seff $SLURM_JOBID

EOF
