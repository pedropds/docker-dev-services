#!/bin/bash

# Source the common environment variables
source ./env.sh

echo "Displaying logs for all services defined in $COMPOSE_FILE..."
docker-compose -f $COMPOSE_FILE logs -f

echo "Logs are being displayed."
