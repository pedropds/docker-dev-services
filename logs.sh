#!/bin/bash

COMPOSE_FILE="dc-networks.yml:dc-kafka-yml:dc-kafka-tools.yml:dc-minio.yml:dc-postgres.sql"

echo "Displaying logs for all services defined in $COMPOSE_FILE..."
docker-compose -f $COMPOSE_FILE logs -f

echo "Logs are being displayed."
