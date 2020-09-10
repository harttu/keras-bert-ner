# testi
sbatch scripts/slurm-run-gputest.sh scripts/run-JOBGEN.sh --data_dir=data/GELLUS-1.0.3/conll/standard/ --init_model_dir=/scratch/project_2001426/models/biobert_v1.1_pubmed_std_naming --batch_size=4 --learning_rate=5e-5 --max_seq_length=256 --epochs=3 --comment="testi" --ner_model_dir_name=testi_1 --test_file=test.tsv --early_stopping=false
