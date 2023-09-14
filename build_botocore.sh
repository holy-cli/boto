#!/bin/bash
set -e

export BOTOCORE_VERSION=1.31.47

echo "Building botocore v$BOTOCORE_VERSION"

# Create virtual environment
if [ ! -d ".env" ]; then
    python3 -m venv .env
    pip install --upgrade setuptools build wheel
fi

source .env/bin/activate

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

# Push to git
git add dist/*
git commit -m "Update botocore wheel file"
git push