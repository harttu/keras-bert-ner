#!/bin/bash

# Run on Turku NER corpus data

# https://stackoverflow.com/a/246128
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -euo pipefail

if [ $# -lt 5 ]; then
	echo "Not aleast 4 arguments were given."
	echo "Got:$@"
	exit 1
fi

comment="Generic ner run"
if [ $# -eq 6 ];then
	comment="$6"
fi

batch_size="$2"
#8
learning_rate="$3"
#5e-5
max_seq_length="$4"
#128
epochs="$5"
#2

datadir="$SCRIPTDIR/../data/AnatEM-1.0.2/conll_single_class/"
train_data="$datadir/train.tsv"
test_data="$datadir/test.tsv"
ner_model_dir="$SCRIPTDIR/../ner-models/turku-ner2-model"

#modeldir="$SCRIPTDIR/../models/bert-base-finnish-cased-v1"
modeldir="$1"
model="$modeldir/bert_model.ckpt"
vocab="$modeldir/vocab.txt"
config="$modeldir/bert_config.json"

echo "BC2GM script with the following parameters:"
echo "Arguments:$@"
echo "modeldir:$modeldir"
echo "batch_size:$batch_size"
echo "learning rate:$learning_rate"
echo "max seq length:$max_seq_length"
echo "epochs:$epochs"
echo "comment:$comment"

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

python "$SCRIPTDIR/../ner_v2.py" \
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
