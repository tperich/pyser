#!/bin/sh


export BIN_DIR=`dirname $0`
export PROJECT_ROOT=`readlink -f "${BIN_DIR}/.."`


if [ -f /usr/local/bin/cbsd ]; then
  sudo cbsd jexec user=devel jname=pyserback /usr/src/bin/collect.sh
  sudo cbsd jexec user=devel jname=pyserfront /usr/src/bin/collect.sh
else
  ${PROJECT_ROOT}/services/backend/bin/collect.sh
  ${PROJECT_ROOT}/services/frontend/bin/collect.sh
fi

rm -rf ${PROJECT_ROOT}/build
mkdir ${PROJECT_ROOT}/build
cp -r ${PROJECT_ROOT}/services/backend/pyser/static "${PROJECT_ROOT}/build/swaggerui"
cp -r ${PROJECT_ROOT}/services/frontend/build/static "${PROJECT_ROOT}/build/"
cp -r ${PROJECT_ROOT}/services/frontend/build/*.js* "${PROJECT_ROOT}/build/"
cp -r ${PROJECT_ROOT}/services/frontend/build/public/favicon.ico "${PROJECT_ROOT}/build/"
cp -r ${PROJECT_ROOT}/services/frontend/build/public/index.html "${PROJECT_ROOT}/build/"
cp -r ${PROJECT_ROOT}/services/frontend/build/public/robots.txt "${PROJECT_ROOT}/build/"
cp -r ${PROJECT_ROOT}/services/frontend/build/public/static/js "${PROJECT_ROOT}/build/static/"
cp -r ${PROJECT_ROOT}/services/frontend/build/public/static/media/* "${PROJECT_ROOT}/build/static/media/"
