#!/usr/bin/env bash

mkdir -p data/pdfs
wget  --recursive --level 1 \
    --accept 'pdf'  \
    --no-directories \
    --no-check-certificate \
    --directory-prefix data/pdfs \
    'https://www.edd.ca.gov/jobs_and_training/layoff_services_warn.htm'


# Note: at time of writing, wget was unable to locally verify the issuer's authority for www.edd.ca.gov
#       hence the use of "no-check-certificate"
