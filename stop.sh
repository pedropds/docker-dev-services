#!/bin/bash

COMPOSE_FILE="dc-networks.yml:dc-kafka-yml:dc-kafka-tools.yml:dc-minio.yml:dc-postgres.sql"

echo "Stopping all services..."
docker-compose -f $COMPOSE_FILE down

echo "All services stopped."
