#!/usr/bin/env bash

TABULA_URL=https://github.com/tabulapdf/tabula-java/releases/download/v1.0.2/tabula-1.0.2-jar-with-dependencies.jar
TABULA_JAR=./vendor/tabula.jar
TABULA_CHECKSUM=fd26a38e8325caedbce650f03aa5ad449e7580d1d277a24fe26bfc4e6d77fd24 # sha256


function check_jar(){
  _chk="$(shasum -a 256 ${TABULA_JAR} | cut -d ' ' -f 1)"
  if [ "${_chk}" == "${TABULA_CHECKSUM}" ]; then
    echo 1
  else
    echo 0
  fi
}

function download_jar(){
   mkdir -p vendor
   curl -Lo ${TABULA_JAR} ${TABULA_URL}
}


if [ "$(check_jar)" != "1" ]; then
    echo "Downloading tabula jar"
    download_jar

    echo "Checking checksum..."
    if [ "$(check_jar)" != "1" ]; then
        echo "${TABULA_JAR} failed checksum verification" 1>&2
        exit 1
    fi
fi

echo "Checksum of ${TABULA_JAR} verified"

mkdir -p data/tabulate
cp data/pdfs/*.pdf data/tabulate
java -jar vendor/tabula.jar  \
    --lattice --format CSV \
    --pages all \
    --batch data/tabulate
rm data/tabulate/*.pdf
