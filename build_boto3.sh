#!/bin/bash
set -e

export BOTOCORE_WHEEL_FILE="https://github.com/holy-cli/boto/raw/master/dist/botocore-1.31.47-py3-none-any.whl"
export BOTO3_VERSION=1.28.47

echo "Building boto3 v$BOTO3_VERSION"

source .env/bin/activate

# Clone boto3 source code
git clone --depth 1 --branch $BOTO3_VERSION https://github.com/boto/boto3.git

# Replace botocore requirement with wheel file
python replace.py boto3/setup.py $BOTOCORE_WHEEL_FILE

# Build package
cd boto3
python setup.py bdist_wheel

# Copy wheel file
cd ..
cp -rf boto3/dist/*.whl dist/

# Push to git
git add dist/*
git commit -m "Update boto3 wheel file"
git push