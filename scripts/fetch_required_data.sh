#!/bin/bash


EMB_PATH="./embeddings"
if [ ! -d $EMB_PATH ]; then
  mkdir -p $EMB_PATH
fi

cd embeddings
wget -nc http://nlp.stanford.edu/data/glove.840B.300d.zip
unzip glove.840B.300d.zip
rm glove.840B.300d.zip
wget -nc https://dada.cs.washington.edu/qasrl/data/glove_50_300_2.zip
unzip glove_50_300_2.zip
rm glove_50_300_2.zip
cd $OLDPWD

DATA_PATH="./data/"
if [ ! -d $DATA_PATH ]; then
  mkdir -p $DATA_PATH
fi

 Get srl-conll package.
wget -nc -O "${DATA_PATH}/sciERC_processed.tar.gz" http://nlp.cs.washington.edu/sciIE/data/sciERC_processed.tar.gz
tar xf "${DATA_PATH}/sciERC_processed.tar.gz" -C "${DATA_PATH}"
rm "${DATA_PATH}/sciERC_processed.tar.gz"

python scripts/filter_embeddings.py ${EMB_PATH}/glove.840B.300d.txt ${EMB_PATH}/glove.840B.300d.txt.filtered ${DATA_PATH}/processed_data/json/train.json ${DATA_PATH}/processed_data/json/dev.json

python scripts/get_char_vocab.py 
