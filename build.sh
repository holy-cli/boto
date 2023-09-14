#!/bin/bash
set -e

export BOTOCORE_VERSION=1.31.47
export BOTO3_VERSION=1.28.47

# Create virtual environment
python3 -m venv .env
source .env/bin/activate
pip install --upgrade setuptools build wheel

# Clone botocore source code
git clone --depth 1 --branch $BOTOCORE_VERSION https://github.com/boto/botocore.git

# Clean up data folder
python clean.py ./botocore/botocore/data/

# Build package
cd botocore
python setup.py bdist_wheel

# Copy wheel file
cd ..
cp -rf botocore/dist/*.whl dist/