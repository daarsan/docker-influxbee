FROM python:3.6.4-alpine

# Define variables
ENV MIRUBEE_USER=user \
    MIRUBEE_PASSWORD=password \
    INFLUXDB_HOST=localhost \
    INFLUXDB_DATABASE=mirubee \
    INFLUXDB_PORT=8086 \
    INFLUXDB_USER=root \
    INFLUXDB_PASSWORD=root \
    REQUESTS_PER_DAY=100

# Install build deps, then run `pip install`, then remove unneeded build deps all in a single step. Correct the path to
# your production requirements file, if needed.
RUN set -ex \
    && apk update \
    && apk add --no-cache --virtual .build-deps \
            git

# Clone the repository
RUN echo "**** install app ****" \
    && git clone https://github.com/daarsan/influxbee /influxbee
    && python3 -m venv /influxbee/venv \
    && /influxbee/venv/bin/pip install -U pip \
    && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "/influxbee/venv/bin/pip install --no-cache-dir -r /influxbee/requirements.txt"

# Copy your application code to the container (make sure you create a .dockerignore file if any large files or directories should be excluded)
COPY influxbee.sh /influxbee/influxbee.sh
RUN mkdir /config && \
    chmod +x /influxbee/influxbee.sh
WORKDIR /influxbee

VOLUME /config

ENTRYPOINT ["/influxbee/influxbee.sh"]
