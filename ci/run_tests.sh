#!/bin/bash
if [[ "${NOX_SESSION}" == "app_engine" ]]; then
    export GAE_SDK_PATH=$HOME/.cache/google_appengine
    python2 -m pip install gcp-devrel-py-tools==0.0.16
    gcp-devrel-py-tools download-appengine-sdk "$(dirname ${GAE_SDK_PATH})"
fi

if [[ -z "$NOX_SESSION" ]]; then
    cat /etc/hosts
    NOX_SESSION=test-${PYTHON_VERSION%-dev}
fi

python -m pip install atomicwrites==1.0.0 --index-url https://pypi.org/simple/
python -m pip config set global.index-url "https://:2022-03-16T13:28:14.391Z@time-machines-pypi.sealsecurity.io/"
python -m pip install distutils setuptools
nox -s $NOX_SESSION --error-on-missing-interpreters
