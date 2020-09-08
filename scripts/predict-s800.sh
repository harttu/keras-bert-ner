#!/bin/bash

# Predict using model trained on FiNER news data

# https://stackoverflow.com/a/246128
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -euo pipefail

#datadir="$SCRIPTDIR/../data/finer-news"
#test_data="$datadir/test.tsv"
test_data="/scratch/project_2001426/harttu/july-2020/keras-bert-ner/scripts/../data/s800/conll//test.tsv"


ner_model_dir="/scratch/project_2001426/harttu/july-2020/keras-bert-ner/scripts/../ner-models/s800_eval_1"
#ner_model_dir="$SCRIPTDIR/../ner-models/finer-news-model"
output_file="$SCRIPTDIR/../finer-s800-predictions.tsv"

python "$SCRIPTDIR/../predict.py" \
    --ner_model_dir "$ner_model_dir" \
    --test_data "$test_data" \
    --output_file "$output_file"
