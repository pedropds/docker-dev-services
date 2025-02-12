#!/bin/bash

# Define the Compose file list as a global variable
COMPOSE_FILE="dc-networks.yml:dc-kafka-yml:dc-kafka-tools.yml:dc-minio.yml:dc-postgres.sql:dc-valkey.yml"

export COMPOSE_FILE
