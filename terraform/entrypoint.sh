#!/bin/bash

set -x
set -e
set -o pipefail

cd main/config

for file in *.envsubst; do \
  envsubst < ${file} > ${file%.envsubst}; \
done

export TF_INPUT=0
export TF_IN_AUTOMATION=1

exec terraform $@
