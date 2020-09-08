sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh 			data/bc2gm-corpus/combined-data/conll-narrow/  batch_size_arr learning_rate_arr in  "Hyperparameter experiment 2" ParHyperB1
sbatch scripts/slurm-run.sh scripts/run-bc2gm.sh 			data/bc2gm-corpus/combined-data/conll-narrow/  batch_size_arr learning_rate_arr max_seq_len_arr  "Hyperparameter experiment 2" ParHyperB2
