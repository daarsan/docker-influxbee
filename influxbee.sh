#!/bin/bash

source /influxbee/venv/bin/activate

python influxbee.py -u $MIRUBEE_USER -p ${MIRUBEE_PASSWORD} --config-file /config/mirubee.toml --influxdb-host ${INFLUXDB_HOST} --influxdb-port ${INFLUXDB_PORT} --influxdb-database ${INFLUXDB_DATABASE} --influxdb-user ${INFLUXDB_USER} --influxdb-password ${INFLUXDB_PASSWORD} --requests-per-day ${REQUESTS_PER_DAY}
