#!/bin/bash -eu

for beat in "$@"; do
  echo Installing index template for ${beat}
  cd /usr/share/${beat}/kibana/
  ./import_dashboards.sh
done
