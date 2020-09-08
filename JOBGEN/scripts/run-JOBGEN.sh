#!/bin/bash

# Run on Turku NER corpus data

# https://stackoverflow.com/a/246128
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -euo pipefail

if [ $# -ne 9 ]; then
	echo "Not 9 arguments were given."
	echo "Got:$@"
	echo "$# arguments"
	exit 1
fi

datadir="$SCRIPTDIR/../$1"
modeldir="$2"
batch_size="$3"
learning_rate="$4"
max_seq_length="$5"
epochs="$6"
comment="$7"
ner_model_dir_name="$8"
testtype="$9"

#datadir="$SCRIPTDIR/../data/bc2gm-corpus/combined-data/conll-wide/"
train_data="$datadir/train.tsv"
#test_data="$datadir/devel.tsv"
#test_data="$datadir/test.tsv"
test_data="${datadir}/${testtype}"
#ner_model_dir="$SCRIPTDIR/../ner-models/turku-ner-model"
ner_model_dir="$SCRIPTDIR/../../ner-models/$ner_model_dir_name"

#modeldir="$SCRIPTDIR/../models/bert-base-finnish-cased-v1"
model="$modeldir/bert_model.ckpt"
vocab="$modeldir/vocab.txt"
config="$modeldir/bert_config.json"

echo "BC2GM script with the following parameters:"
echo "time: "`date`
echo "Arguments: $@"
echo "datadir: $datadir"
echo "traindata: $train_data"
echo "testdata: $test_data"
echo "modeldir: $modeldir"
echo "batch_size: $batch_size"
echo "learning rate: $learning_rate"
echo "max seq length: $max_seq_length"
echo "epochs: $epochs"
echo "comment: $comment"
echo "saving in: $ner_model_dir"

if [ ! -e "$datadir" ]; then
    echo "Data not found (run scripts/get-turku-ner.sh?)" >&2
    exit 1
fi

if [ ! -e "$modeldir" ]; then
    echo "Model not found (run scripts/get-models.sh?)" >&2
    exit 1
fi

rm -rf "$ner_model_dir"
mkdir -p "$ner_model_dir"

echo "Now training:"

python "$SCRIPTDIR/../../ner.py" \
    --vocab_file "$vocab" \
    --bert_config_file "$config" \
    --init_checkpoint "$model" \
    --learning_rate $learning_rate \
    --num_train_epochs $epochs \
    --max_seq_length $max_seq_length \
    --batch_size $batch_size \
    --train_data "$train_data" \
    --test_data "$test_data" \
    --ner_model_dir "$ner_model_dir" \

#echo "Now testing:"
#test_data="$datadir/test.tsv"

#ner_model_dir="$SCRIPTDIR/../ner-models/turku-ner-model"                                                                                                                                                  

#output_file="$SCRIPTDIR/../turku-ner-predictions.tsv"                                                                                                                                                      
                                                                                                                                                                                                           
#python "$SCRIPTDIR/../predict.py" \                                                                                                                                                                        
#    --ner_model_dir "$ner_model_dir" \                                                                                                                                                                     
#    --test_data "$test_data" \                                                                                                                                                                             
#    --output_file "$output_file"    

#echo "Now comparing:"
#python compare.py data/turku-ner/test.tsv turku-ner-predictions.tsv 
