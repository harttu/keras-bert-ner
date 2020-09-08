#!/bin/bash

# Run on Turku NER corpus data

# https://stackoverflow.com/a/246128
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -euo pipefail

early_stopping=false

for i in "$@"
do
case $i in
    -bs=*|--batch_size=*)
    batch_size="${i#*=}"
    shift # past argument=value
    ;;
    -lr=*|--learning_rate=*)
    learning_rate="${i#*=}"
    shift # past argument=value
    ;;
    -msl=*|--max_seq_len=*)
    max_seq_length="${i#*=}"
    shift # past argument=value
    ;;
    -e=*|--epochs=*)
    epochs="${i#*=}"
    shift # past argument=value
    ;;
    -c=*|--comment=*)
    comment="${i#*=}"
    shift # past argument=value
    ;;
    -es=*|--early_stopping=*)
    early_stopping="${i#*=}"
    shift # past argument=value
    ;;
    -c=*|--comment=*)
    comment="${i#*=}"
    shift # past argument=value
    ;;
    -m=*|--model_dir=*)
    model_dir="${i#*=}"
    shift # past argument=value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    *)
          # unknown option
    ;;
esac
done

data_dir="$SCRIPTDIR/../data/AnatEM-1.0.2/conll_single_class/"
train_data="$datadir/train.tsv"
test_data="$datadir/test.tsv"
ner_model_dir="$SCRIPTDIR/../ner-models/turku-ner2-model"

#modeldir="$SCRIPTDIR/../models/bert-base-finnish-cased-v1"
#modeldir="$1"
model="$model_dir/bert_model.ckpt"
vocab="$model_dir/vocab.txt"
config="$model_dir/bert_config.json"

echo "BC2GM script with the following parameters:"
echo "Arguments:$@"
echo "init. modeldir:$model_dir"
echo "checkpoint modeldir:$ner_model_dir"
echo "datadir:$data_dir"
echo "batch_size:$batch_size"
echo "learning rate:$learning_rate"
echo "max seq length:$max_seq_length"
echo "epochs:$epochs"
echo "early stopping:$early_stopping"
echo "comment:$comment"

if [ ! -e "$data_dir" ]; then
    echo "Data not found (run scripts/get-turku-ner.sh?)" >&2
    exit 1
fi

if [ ! -e "$model_dir" ]; then
    echo "Model not found (run scripts/get-models.sh?)" >&2
    exit 1
fi

rm -rf "$ner_model_dir"
mkdir -p "$ner_model_dir"

pythonargs="--vocab_file $vocab \
    --bert_config_file $config \
    --init_checkpoint $model \
    --learning_rate $learning_rate \
    --num_train_epochs $epochs \
    --max_seq_length $max_seq_length \
    --batch_size $batch_size \
    --train_data $train_data \
    --test_data $test_data \
    --ner_model_dir $ner_model_dir
"
if test $early_stopping = true; then
pythonargs="$pythonargs --early_stopping"
fi
#echo $pythonargs

python "$SCRIPTDIR/../ner_v2.py" $pythonargs


#    --vocab_file "$vocab" \
#    --bert_config_file "$config" \
#    --init_checkpoint "$model" \
#    --learning_rate $learning_rate \
#    --num_train_epochs $epochs \
#    --max_seq_length $max_seq_length \
#    --batch_size $batch_size \
#    --train_data "$train_data" \
#    --test_data "$test_data" \
#    --ner_model_dir "$ner_model_dir" \
#    --early_stopping "$early_stopping"
