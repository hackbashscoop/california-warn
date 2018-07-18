#!/usr/bin/env bash

SRC_DIR=data/pdfs
DEST_DIR=data/rawtext

mkdir -p ${DEST_DIR}

find data/pdfs/*.pdf \
    | while read -r fname; do
        tname=${DEST_DIR}/$(basename $fname | sed 's/.pdf/.txt/')
        pdftotext -layout $fname $tname
        echo  "Created: $tname"
done
