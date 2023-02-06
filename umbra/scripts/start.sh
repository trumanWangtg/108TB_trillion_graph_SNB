#!/usr/bin/env bash

set -eu
set -o pipefail

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ..

. scripts/vars.sh

python3 -c 'import psycopg2' || (echo "psycopg2 Python package is missing or broken" && exit 1)

echo -n "Outputting Umbra parameters"
docker run \
    --volume=${UMBRA_DATABASE_DIR}:/var/db/:z \
    --volume=${UMBRA_DDL_DIR}:/ddl/:z \
    --env USEDIRECTIO=1 \
    ${UMBRA_DOCKER_BUFFERSIZE_ENV_VAR} \
    ${UMBRA_DOCKER_IMAGE} \
    umbra_sql \
      "" \
      /ddl/output-env.sql

echo -n "Starting the database . "
docker run \
    --name ${UMBRA_CONTAINER_NAME} \
    --detach \
    --volume=${UMBRA_CSV_DIR}:/data/:z \
    --volume=${UMBRA_DATABASE_DIR}:/var/db/:z \
    --volume=${UMBRA_DDL_DIR}:/ddl/:z \
    --volume=${UMBRA_LOG_DIR}:/var/log/:z \
    --publish=8000:5432 \
    --env USEDIRECTIO=1 \
    ${UMBRA_DOCKER_BUFFERSIZE_ENV_VAR} \
    ${UMBRA_DOCKER_IMAGE} \
    umbra_server \
        --address 0.0.0.0 \
        /var/db/ldbc.db \
    >/dev/null

until python3 scripts/test-db-connection.py > /dev/null 2>&1; do
    echo -n ". "
    sleep 1
done
echo "Database started."
