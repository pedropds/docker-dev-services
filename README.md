# Docker Development Services

This repository contains Docker Compose configurations to manage essential development services such as Kafka, PostgreSQL, and MinIO. You can easily select which services to run using interactive shell menus.

## Available Services

- **Kafka**: Distributed event streaming platform.
- **Kafka Tools**: Utilities for managing Kafka.
- **PostgreSQL**: Powerful, open-source object-relational database.
- **MinIO**: High-performance, S3-compatible object storage.

## Prerequisites

- [Docker](https://www.docker.com/) installed and running.
- [Docker Compose](https://docs.docker.com/compose/) installed.
- [Dialog for macOS (Homebrew)](https://formulae.brew.sh/formula/dialog) or
  [Dialog for Linux](https://bash.cyberciti.biz/guide/Bash_display_dialog_boxes)

## How to Run

1. Clone the repository:

   ```bash
   git clone https://github.com/pedropds/docker-dev-services.git
   cd docker-dev-services
   ```

2. Make the scripts executable:

   ```bash
   chmod +x start-services.sh stop.sh logs.sh env.sh
   ```

3. Start services by running the interactive selection script:

   ```bash
   ./start.sh
   ```

4. An interactive dialog will appear. Use the **SPACEBAR** to select services and **ENTER** to confirm.

5. The selected services will start, and logs will be displayed.

## Managing Services

### Stopping Services

To stop all running services, use:

```bash
./stop.sh
```

This script stops and cleans up all Docker Compose services.

### Viewing Logs

To view the logs of all services, run:

```bash
./logs.sh
```

This will display the logs for all active services.

### Common Environment Variables

Service configurations are managed through the `env.sh` file, which defines the `COMPOSE_FILE` environment variable. This variable lists all the Docker Compose files used by the scripts.

To update or modify the list of services, edit the `env.sh` file:

```bash
#!/bin/bash

# Define the Compose file list as a global variable
COMPOSE_FILE="dc-networks.yml:dc-kafka-yml:dc-kafka-tools.yml:dc-minio.yml:dc-postgres.sql"
export COMPOSE_FILE
```

## Environment Variable Configuration

By default, the `COMPOSE_FILE` environment variable is set to include the selected service files. You can customize additional configurations by modifying the Docker Compose YAML files.

## Troubleshooting

- **No Services Selected:** If you select no services, the script will exit gracefully.
- **Port Conflicts:** Ensure no other services are running on the same ports as the ones defined in the compose files.
- **Docker Compose Errors:** Verify that Docker is running and all required files are available.

## Extending Services

To add new services:

1. Create a new Docker Compose file (e.g., `dc-newservice.yml`).
2. Update the script to include the service name and file.

```bash
SERVICE_NAMES+=("New Service")
SERVICE_FILES+=("dc-newservice.yml")
```
