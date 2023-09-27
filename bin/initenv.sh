#!/bin/bash

# This file sets up the python version and environment
# To use source this file in your shell.
WORKING_DIR="$( cd "$( dirname "$0" )" &> /dev/null && pwd )"
PROJECT_ROOT="$( cd "${WORKING_DIR}/.." &> /dev/null && pwd )"
PYTHON_VERSION="$(cat ${PROJECT_ROOT}/.python-version)"
export PYENV_ENVIRONMENT_ROOT="${PROJECT_ROOT}/venv"

# Check if pyenv command exists on shell, and create if needed
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Install python version if needed
pyenv install -s ${PYTHON_VERSION}

if [ ! -d venv ]; then
  $(pyenv which python3) -m venv "venv"
fi

# Activate python environment
source "venv/bin/activate"

python -m pip install --upgrade pip
python -m pip install -r "${PROJECT_ROOT}/requirements.txt"

# For Jupyter Notebooks, make sure to install a Kernel
# ipykernel installed already from requirements file
python3 -m ipykernel install --user --name=$WORKING_DIR
