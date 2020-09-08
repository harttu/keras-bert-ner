Submitted batch job 3062752
Submitted batch job 3062753
Submitted batch job 3062754
Submitted batch job 3062755
Submitted batch job 3062756
Submitted batch job 3062757
Submitted batch job 3062758
Submitted batch job 3062759
Submitted batch job 3062760
Submitted batch job 3062761
Submitted batch job 3062762


sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/NCBI_BERT_pubmed_uncased_L-24_H-1024_A-16s800_1 8 5e-5 192 4 "s800 modeltryout" NCBI_uncased_L24
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/scibert_scivocab_caseds800_1 8 5e-5 192 4 "s800 modeltryout" scibert_cased
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/biobert_v1.1_pubmed_std_namings800_1 8 5e-5 192 4 "s800 modeltryout" biobert_pubmed
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/biobert_v1.0_pubmed_pmcs800_1 8 5e-5 192 4 "s800 modeltryout" biobert_pubmed_pmc
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/uncased_L-24_H-1024_A-16s800_1 8 5e-5 192 4 "s800 modeltryout" uncased_L24
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/scibert_scivocab_uncaseds800_1 8 5e-5 192 4 "s800 modeltryout" scibert_uncased
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/cased_L-12_H-768_A-12s800_1 8 5e-5 192 4 "s800 modeltryout" cased_L12
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/wwm_cased_L-24_H-1024_A-16s800_1 8 5e-5 192 4 "s800 modeltryout" wwm_cased_L24
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/uncased_L-12_H-768_A-12s800_1 8 5e-5 192 4 "s800 modeltryout" uncased_L12
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/biobert_larges800_1 8 5e-5 192 4 "s800 modeltryout" biobert_large
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh data/bc2gm-corpus/combined-data/conll-wide/ /scratch/project_2001426/models/NCBI_BERT_pubmed_uncased_L-12_H-768_A-12s800_1 8 5e-5 192 4 "s800 modeltryout" NCBI_uncased_L12
