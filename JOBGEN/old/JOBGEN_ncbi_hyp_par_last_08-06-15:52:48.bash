sbatch scripts/slurm-run.sh scripts/run-JOBGEN.sh data/ncbi-disease/conll/ /scratch/project_2001426/models/biobert_v1.1_pubmed_std_naming 8 5e-5 128 5 "ncbi_hyp_par_last" ncbi_hyp_par_last_1 devel.tsv
sbatch scripts/slurm-run.sh scripts/run-JOBGEN.sh data/ncbi-disease/conll/ /scratch/project_2001426/models/biobert_v1.1_pubmed_std_naming 8 5e-5 256 5 "ncbi_hyp_par_last" ncbi_hyp_par_last_2 devel.tsv
sbatch scripts/slurm-run.sh scripts/run-JOBGEN.sh data/ncbi-disease/conll/ /scratch/project_2001426/models/biobert_v1.1_pubmed_std_naming 8 5e-5 320 5 "ncbi_hyp_par_last" ncbi_hyp_par_last_3 devel.tsv
sbatch scripts/slurm-run.sh scripts/run-JOBGEN.sh data/ncbi-disease/conll/ /scratch/project_2001426/models/wwm_cased_L-24_H-1024_A-16 8 5e-5 128 5 "ncbi_hyp_par_last" ncbi_hyp_par_last_4 devel.tsv
sbatch scripts/slurm-run.sh scripts/run-JOBGEN.sh data/ncbi-disease/conll/ /scratch/project_2001426/models/wwm_cased_L-24_H-1024_A-16 8 5e-5 256 5 "ncbi_hyp_par_last" ncbi_hyp_par_last_5 devel.tsv
sbatch scripts/slurm-run.sh scripts/run-JOBGEN.sh data/ncbi-disease/conll/ /scratch/project_2001426/models/wwm_cased_L-24_H-1024_A-16 8 5e-5 320 5 "ncbi_hyp_par_last" ncbi_hyp_par_last_6 devel.tsv
