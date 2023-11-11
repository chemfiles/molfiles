#!/bin/bash

set -eu

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

cd "$SCRIPT_DIR"

# Create archive with only required files
rm -rf molfiles.tar.gz molfiles
mkdir -p molfiles/src

cp -r ../{include,src,CMakeLists.txt} molfiles/
cp ../LICENSE molfiles/

tar cf molfiles.tar molfiles/
gzip -9 -f molfiles.tar

echo "created 0-chemfiles/molfiles.tar.gz"
