#!/bin/bash

# Predict using model trained on Turku NER corpus data

# https://stackoverflow.com/a/246128
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -euo pipefail

datadir="$SCRIPTDIR/../data/bc2gm-corpus/combined-data/conll-narrow/"
test_data="$datadir/devel.tsv"

#ner_model_dir="$SCRIPTDIR/../ner-models/bc2gm"
#output_file="$SCRIPTDIR/../bc2gm-ner-predictions.tsv"

ner_model_dir="$SCRIPTDIR/../ner-models/$1"
output_file="$ner_model_dir/predictions.tsv"

python "$SCRIPTDIR/../predict.py" \
    --ner_model_dir "$ner_model_dir" \
    --test_data "$test_data" \
    --output_file "$output_file"
