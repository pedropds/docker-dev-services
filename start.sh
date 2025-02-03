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

# Define which services should be selected by default
DEFAULT_SELECTION=(
)

# Prepare dialog options (default "OFF" for each, or "ON" if it is in the DEFAULT_SELECTION list)
MENU_OPTIONS=()
for i in "${!SERVICE_NAMES[@]}"; do
  name="${SERVICE_NAMES[$i]}"
  file="${SERVICE_FILES[$i]}"

  # Check if the service is in the default selection list
  if [[ " ${DEFAULT_SELECTION[@]} " =~ " ${file} " ]]; then
    MENU_OPTIONS+=("$file" "$name" "ON")
  else
    MENU_OPTIONS+=("$file" "$name" "OFF")
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

# Append selected services to COMPOSE_FILES
for service in ${SELECTED}; do
  # Only add the service files to COMPOSE_FILES (not names)
  COMPOSE_FILES="$COMPOSE_FILES:$service"
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