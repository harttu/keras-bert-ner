sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/biobert_v1.1_pubmed_std_naming 16 5e-5 128 4 "bc2g with 4 models 4 epoch" biobert_pubmed
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/biobert_v1.0_pubmed_pmc 16 5e-5 128 4 "bc2g with 4 models 4 epoch" biobert_pubmed_pmc
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/wwm_cased_L-24_H-1024_A-16 16 5e-5 128 4 "bc2g with 4 models 4 epoch" wwm_cased_L24
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/biobert_large 16 5e-5 128 4 "bc2g with 4 models 4 epoch" biobert_large
