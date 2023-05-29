#!/bin/bash -eu

for beat in "$@"; do
  echo Installing index template for ${beat}
  curl -XPUT "http://localhost:9200/_template/${beat}" -d@/etc/${beat}/${beat}.template.json
done
