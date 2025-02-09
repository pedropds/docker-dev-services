#!/bin/bash

# Source the common environment variables
source ./env.sh

echo "Stopping all services..."
docker-compose -f $COMPOSE_FILE down

echo "All services stopped."
