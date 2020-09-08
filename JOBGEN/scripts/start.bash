#!/bin/bash
set -euxo pipefail

declare -A Data
Data[gellus]="../data/GELLUS-1.0.3/conll/standard/"
Data[bc2gmwide]="../data/bc2gm-corpus/combined-data/conll-wide/"
Data[s800]="../data/s800/conll/"
Data[ncbi]="../data/ncbi-disease/conll/"
Data[chemdner]="../data/chemdner-corpora/conll"
datadir="${Data[gellus]}"

declare -A Models;
Models[biobert_large]=/scratch/project_2001426/models/biobert_large 
#models[NCBI_uncased_L12]=/scratch/project_2001426/models/NCBI_BERT_pubmed_uncased_L-12_H-768_A-12
Models[biobert_pubmed]=/scratch/project_2001426/models/biobert_v1.1_pubmed_std_naming
#models[scibert_uncased]=/scratch/project_2001426/models/scibert_scivocab_uncased
#models[scibert_cased]=/scratch/project_2001426/models/scibert_scivocab_cased
#models[biobert_pubmed_pmc]=/scratch/project_2001426/models/biobert_v1.0_pubmed_pmc
#models[NCBI_uncased_L24]=/scratch/project_2001426/models/NCBI_BERT_pubmed_uncased_L-24_H-1024_A-16
#models[wwm_cased_L24]=/scratch/project_2001426/models/wwm_cased_L-24_H-1024_A-16
#models[uncased_L24]=/scratch/project_2001426/models/uncased_L-24_H-1024_A-16
#models[uncased_L12]=/scratch/project_2001426/models/uncased_L-12_H-768_A-12
#models[cased_L12]=/scratch/project_2001426/models/cased_L-12_H-768_A-12

declare -A ModelSize
ModelSize[biobert_large]="L"
ModelSize[biobert_pubmed]="N"

echo "Give name description for this run (no spaces)"
read comment

declare -A SlurmSetup
SlurmSetup[L]="gpu 8G 00:30:00 $comment"
SlurmSetup[N]="gpu 8G 00:15:00 $comment"

epochs_arr=(4)
max_seq_len_arr=(2)
#(128 192 256 320 384)
learning_rate_arr=("5e-5")
batch_size_arr=(4)
timenow=$(date +"%m-%d-%T")
testtype="devel.tsv"

projectdir="runs/${comment}"
OUTPUTFILE="../JOBGEN_${comment}_${timenow}.bash"

mkdir "../$projectdir"
mkdir "../$projectdir/slurm/"
echo "#CREATED AT "`date` >> "../${projectdir}/INFO"

counter=0

for model in "${!Models[@]}"
do
	# prepare a propriate slurm script for the run
	slurmscript="${projectdir}/slurm/slurm-${model}.sh"
	
	echo "Writing ${slurmscript}"
	if [ "${ModelSize[$model]}" == "L" ]
	then
		awk -v gputype="gputest" -v mem="32G" -v time="00:15:00" -v dir="${comment}" -f template_parser.awk ../slurm.template > "../$slurmscript"
	elif [ "${ModelSize[$model]}" == "N" ]
	then
		awk -v gputype="gputest" -v mem="32G" -v time="00:15:00" -v dir="${comment}" -f template_parser.awk ../slurm.template > "../$slurmscript"
	else
		echo "No match for $model in $ModelSize"
		exit 1
	fi
	
	for max_seq_len in "${max_seq_len_arr[@]}"; 
	do
		for learning_rate in "${learning_rate_arr[@]}";
		do
			for batch_size in "${batch_size_arr[@]}";
			do
				counter=$((counter+1))
				model_dir="${Models[$model]}"
				epochs=${epochs_arr[0]}
				#comment="s800_biobert_hypop_1"
				ner_saving_dir="${comment}_$counter"
				echo "sbatch $slurmscript scripts/run-JOBGEN.sh $datadir $model_dir $batch_size $learning_rate $max_seq_len $epochs \"$comment\" $ner_saving_dir $testtype" >> $OUTPUTFILE
			done
		done
	done
done

exit 1
command=`head -1 $OUTPUTFILE | awk '{ gsub(/slurm-run/,"slurm-run-gputest"); print; }'`
echo $command >> "${OUTPUTFILE}.DEBUG"
echo "Written: $OUTPUTFILE"
#echo "Do you want to run debug command: $command"
#read yesno
#if( yesno 

chmod +x $OUTPUTFILE




