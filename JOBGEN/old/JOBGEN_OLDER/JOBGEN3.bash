Wed Jul 29 10:00:48 EEST 2020
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/NCBI_BERT_pubmed_uncased_L-24_H-1024_A-16 8 5e-5  2 "bc2g with 1 epoch" NCBI_uncased_L24
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/biobert_v1.1_pubmed 8 5e-5  2 "bc2g with 1 epoch" biobert_pubmed
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/biobert_v1.0_pubmed_pmc 8 5e-5  2 "bc2g with 1 epoch" biobert_pubmed_pmc
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/uncased_L-24_H-1024_A-16 8 5e-5  2 "bc2g with 1 epoch" uncased_L24
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/scibert_scivocab_uncased 8 5e-5  2 "bc2g with 1 epoch" scibert_uncased
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/cased_L-12_H-768_A-12 8 5e-5  2 "bc2g with 1 epoch" cased_L12
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/wwm_cased_L-24_H-1024_A-16 8 5e-5  2 "bc2g with 1 epoch" wwm_cased_L24
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/uncased_L-12_H-768_A-12 8 5e-5  2 "bc2g with 1 epoch" uncased_L12
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/biobert_large 8 5e-5  2 "bc2g with 1 epoch" biobert_large
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh /scratch/project_2001426/models/NCBI_BERT_pubmed_uncased_L-12_H-768_A-12 8 5e-5  2 "bc2g with 1 epoch" NCBI_uncased_L12
