#!/bin/bash
set -euo pipefail

declare -A Data
Data[gellus]="data/GELLUS-1.0.3/conll/standard/"
Data[bc2gmnarrow]="data/bc2gm-corpus/combined-data/conll-narrow/"
Data[bc2gmwide]="data/bc2gm-corpus/combined-data/conll-wide/"
Data[bc2gmwidesmaller]="data/bc2gm-corpus-smaller/conll-wide"
Data[s800]="data/s800/conll/"
Data[s800_conll2]="data/s800/conll2/"
Data[ncbi]="data/ncbi-disease/conll/"
Data[chemdner]="/data/chemdner-corpora/conll"
Data[chemdnersmaller]="data/chemdner-smaller/conll"
Data[linnaeus]="data/linnaeus-corpus/conll"
Data[linnaeus_train_s800_test]="data/linnaeus_train_s800_devtest/conll"
Data[s800_train_linnaeus_test]="data/s800_train_linnaeus_devtest/conll"
Data[linnaeus_devtraincombined]="/data/linnaeus_devtrain_combined/conll"
Data[anatEM]="/data/AnatEM-1.0.2/conll"
Data[anatEMSingle]="/data/AnatEM-1.0.2/conll_single_class"
Data[anatEMSingleConll2]="/data/AnatEM-1.0.2/conll2_single_class"

#datadir=${Data[bc2gmnarrow]}
#datadir=${Data[bc2gmwidesmaller]}
#datadir=${Data[linnaeus]}
#datadir=${Data[linnaeus_train_s800_test]}
#datadir=${Data[s800_train_linnaeus_test]}
#datadir=${Data[s800]}
#datadir=${Data[chemdnersmaller]}
#datadir=${Data[chemdner]}
#datadir=${Data[linnaeus_devtraincombined]}
#datadir=${Data[bc2gmwide]}
datadir=${Data[gellus]}
#datadir=${Data[anatEM]}
#datadir=${Data[anatEMSingle]}
#datadir=${Data[ncbi]}
#datadir=${Data[s800_conll2]}
#datadir=${Data[anatEMSingleConll2]}

declare -A Models;
#Models[biobert_large]=/scratch/project_2001426/models/biobert_large 
#Models[NCBI_uncased_L12]=/scratch/project_2001426/models/NCBI_BERT_pubmed_uncased_L-12_H-768_A-12
Models[biobert_pubmed]=/scratch/project_2001426/models/biobert_v1.1_pubmed_std_naming
#Models[scibert_uncased]=/scratch/project_2001426/models/scibert_scivocab_uncased
#Models[scibert_cased]=/scratch/project_2001426/models/scibert_scivocab_cased
#Models[biobert_pubmed_pmc]=/scratch/project_2001426/models/biobert_v1.0_pubmed_pmc
#Models[NCBI_uncased_L24]=/scratch/project_2001426/models/NCBI_BERT_pubmed_uncased_L-24_H-1024_A-16
#Models[wwm_cased_L24]=/scratch/project_2001426/models/wwm_cased_L-24_H-1024_A-16
#Models[uncased_L24]=/scratch/project_2001426/models/uncased_L-24_H-1024_A-16
#Models[uncased_L12]=/scratch/project_2001426/models/uncased_L-12_H-768_A-12
#Models[cased_L12]=/scratch/project_2001426/models/cased_L-12_H-768_A-12

declare -A ModelSize
ModelSize[biobert_large]="L"
ModelSize[biobert_pubmed]="N"
ModelSize[NCBI_uncased_L12]="N"
ModelSize[scibert_uncased]="N"
ModelSize[scibert_cased]="N"
ModelSize[biobert_pubmed_pmc]="N"
ModelSize[NCBI_uncased_L24]="L"
ModelSize[wwm_cased_L24]="L"
ModelSize[uncased_L24]="L"
ModelSize[uncased_L12]="N"
ModelSize[cased_L12]="N"

echo "Using data:$datadir"
echo "Give name description for this run (no spaces)"
read comment

#declare -A SlurmSetup
#SlurmSetup[L]="gpu 16G 05:30:00 $comment"
#SlurmSetup[N]="gpu 16G 02:30:00 $comment"

repeats_arr=(1)
# 2 3 4)
epochs_arr=(3)
max_seq_len_arr=(256)
#(128 192 256 288 320 356)
#(224 240 256 288 320 352 384) 
#(128 192 256 288 320)
#(256 288 320 336 356)
#(128 192 256 288 320)
#(168 176 184)
#(144 160 176 192)
#(128 192 256 288 320)
#(128 192 256 320 384)
learning_rate_arr=("5e-5")
batch_size_arr=(4)
# 8 16) 
#(4 8 16 32)
timenow=$(date +"%m-%d-%T")
testtype="test.tsv"
early_stopping=false
#true

projectdir="runs/${comment}"
OUTPUTFILE="JOBGEN_${comment}_${timenow}.bash"
echo "# $comment" > "$OUTPUTFILE"

mkdir "$projectdir"
mkdir "$projectdir/slurm/"
echo "#CREATED AT "`date` >> "${projectdir}/INFO"

counter=0

for model in "${!Models[@]}"
do
	# prepare a propriate slurm script for the run
	slurmscript="${projectdir}/slurm/slurm-${model}.sh"
	
	echo "Writing ${slurmscript}"
	if [ "${ModelSize[$model]}" == "L" ]
	then
		awk -v gputype="gpu" -v mem="16G" -v time="02:00:00" -v dir="${comment}" -f template_parser.awk slurm/slurm.template > "$slurmscript"
	elif [ "${ModelSize[$model]}" == "N" ]
	then
		awk -v gputype="gpu" -v mem="16G" -v time="01:00:00" -v dir="${comment}" -f template_parser.awk slurm/slurm.template > "$slurmscript"
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
				for epochs in "${epochs_arr[@]}";
				do
					for repeat in "${repeats_arr[@]}";
					do
						counter=$((counter+1))
						model_dir="${Models[$model]}"
						#epochs=${epochs_arr[0]}
						#comment="s800_biobert_hypop_1"
						ner_saving_dir="${comment}_$counter"
						#echo "sbatch $slurmscript scripts/run-JOBGEN.sh $datadir $model_dir $batch_size $learning_rate $max_seq_len $epochs \"$comment\" $ner_saving_dir $testtype" >> $OUTPUTFILE

sbatch_cmd="sbatch $slurmscript scripts/run-JOBGEN.sh --data_dir=$datadir \
--init_model_dir=$model_dir --batch_size=$batch_size --learning_rate=$learning_rate \
--max_seq_length=$max_seq_len --epochs=$epochs --comment=\"$comment\" --ner_model_dir_name=$ner_saving_dir \
--test_file=$testtype --early_stopping=$early_stopping"

sbatch_cmd_eval="sbatch $slurmscript scripts/run-JOBGEN.sh --data_dir=$datadir \
--init_model_dir=$model_dir --batch_size=$batch_size --learning_rate=$learning_rate \
--max_seq_length=$max_seq_len --epochs=$epochs --comment=\"$comment\" --ner_model_dir_name=$ner_saving_dir \
--test_file=train.tsv --early_stopping=false"

echo $sbatch_cmd >> $OUTPUTFILE
echo "########################" >> "$OUTPUTFILE.start_eval"
echo "#$max_seq_len $batch_size $learning_rate $epochs " >> "$OUTPUTFILE.start_eval"
echo "#for i in (1 2 3 4); do echo $sbatch_cmd_eval ; done" >> "$OUTPUTFILE.start_eval"

					done
				done 
			done
		done
	done
done

#exit 1
# generate a file that can be easily used for launching the evaluation test
cp jobgenreport.awk $projectdir
cp JOBGEN/send_results.bash $projectdir
cp JOBGEN/get_results.bash $projectdir
awk '{sub(/devel.tsv/,"test.tsv"); print $0}' $OUTPUTFILE >> "${OUTPUTFILE}.TEST_START"
command=`head -1 $OUTPUTFILE | awk '{ gsub(/slurm-run/,"slurm-run-gputest"); print; }'`
echo $command >> "${OUTPUTFILE}.DEBUG"
echo "Written: $OUTPUTFILE"
#echo "Do you want to run debug command: $command"
#read yesno
#if( yesno 

chmod +x $OUTPUTFILE
# keep record of the runs
echo -e `date`"\t$comment" >> runs/runs.log



