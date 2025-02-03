#!/bin/bash

# Define service objects with custom names and filenames
declare -a SERVICE_NAMES=(
  "Kafka"
  "Kafka Tools"
  "PostgreSQL"
  "MinIO"
)

declare -a SERVICE_FILES=(
  "dc-kafka.yml"
  "dc-kafka-tools.yml"
  "dc-postgres.yml"
  "dc-minio.yml"
)

# Define which services should be selected by default (using indices)
DEFAULT_SELECTION=()

# Prepare dialog options
MENU_OPTIONS=()
for i in "${!SERVICE_NAMES[@]}"; do
  name="${SERVICE_NAMES[$i]}"

  # Check if the index is in the default selection list
  if [[ " ${DEFAULT_SELECTION[@]} " =~ " $i " ]]; then
    MENU_OPTIONS+=("$i" "$name" "ON")
  else
    MENU_OPTIONS+=("$i" "$name" "OFF")
  fi
done

# Use dialog to present the options
SELECTED=$(dialog \
  --backtitle "Docker Compose Service Selector" \
  --title "Select Services to Start" \
  --checklist "Use SPACE to select and ENTER to confirm" 20 60 15 \
  "${MENU_OPTIONS[@]}" \
  2>&1 >/dev/tty)

clear

# If no services are selected, exit
if [ -z "$SELECTED" ]; then
  echo "No services selected. Exiting."
  exit 0
fi

# Set COMPOSE_FILE environment variable, always starting with dc-networks.yml
COMPOSE_FILES="dc-networks.yml"

# Append selected services to COMPOSE_FILES by mapping indices to filenames
for index in $SELECTED; do
  service_file="${SERVICE_FILES[$index]}"
  COMPOSE_FILES="$COMPOSE_FILES:$service_file"
done

# Export the COMPOSE_FILE environment variable
export COMPOSE_FILE=$COMPOSE_FILES

# Run docker-compose up with the selected services
echo "Starting services: $COMPOSE_FILE"
docker-compose up -d

echo "Selected services started."

# Display logs for all the selected services
echo "Displaying logs for all services..."
docker-compose -f $COMPOSE_FILE logs -f
