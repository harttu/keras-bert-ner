sbatch runs/a1/slurm/slurm-biobert_pubmed.sh scripts/run-JOBGEN.sh data/GELLUS-1.0.3/conll/standard/ /scratch/project_2001426/models/biobert_v1.1_pubmed_std_naming 4 5e-5 2 4 "a1" a1_1 devel.tsv
sbatch runs/a1/slurm/slurm-biobert_large.sh scripts/run-JOBGEN.sh data/GELLUS-1.0.3/conll/standard/ /scratch/project_2001426/models/biobert_large 4 5e-5 2 4 "a1" a1_2 devel.tsv
