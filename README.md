# keras-bert-ner

Named entity recognition built on top of BERT and keras-bert. 

## Dependencies:

bert (added as submodule to this project. FullTokenizer is used instead of keras-bert tokenizer)

keras-bert (https://pypi.org/project/keras-bert/)

Pretrained BERT model, e.g. from:
- https://github.com/TurkuNLP/FinBERT
- https://github.com/google-research/bert

input data e.g. from:
- https://github.com/mpsilfve/finer-data

Input data is expected to be in CONLL:ish format where Token and Tag are tab separated. 
First string on the line corresponds to Token and second string to Tag
  
## Quickstart

Get submodules

```
git submodule init
git submodule update
```

Get pretrained models and data

```
./scripts/get-models.sh
./scripts/get-finer.sh
./scripts/get-turku-ner.sh
```

Run an experiment on FiNER news data  (`run-finer-news.sh` trains, `predict-finer-news.sh` outputs predictions)

```
./scripts/run-finer-news.sh
./scripts/predict-finer-news.sh
python compare.py data/finer-news/test.tsv finer-news-predictions.tsv 
```

Experiment on Turku NER corpus data (`run-turku-ner.sh` trains, `predict-turku-ner.sh` outputs predictions)

```
./scripts/run-turku-ner.sh
./scripts/predict-turku-ner.sh
python compare.py data/turku-ner/test.tsv turku-ner-predictions.tsv 
```

If in a Slurm environment, edit `scripts/slurm-run.sh` to match your setup and create virtual environment, e.g.

```
module purge
module load tensorflow
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

then run

```
sbatch scripts/slurm-run.sh scripts/run-finer-news.sh
sbatch scripts/slurm-run.sh scripts/predict-finer-news.sh
python compare.py data/finer-news/test.tsv finer-news-predictions.tsv
```

and

```
sbatch scripts/slurm-run.sh scripts/run-turku-ner.sh
sbatch scripts/slurm-run.sh scripts/predict-turku-ner.sh
python compare.py data/turku-ner/test.tsv turku-ner-predictions.tsv 
```

(the first jobs must finish before running the second ones.)

For parameter selection in a Slurm environment, try

```
./slurm/run-parameter-grid.sh 
python3 slurm/select_params.py logs/*.out
```
