#!/bin/bash

KAFKA_BROKER="kafka:9092"
TOPICS=("input-topic" "output-topic")

check_kafka_connection() {
  kafka-topics --bootstrap-server "$KAFKA_BROKER" --list > /dev/null 2>&1
}

# Wait until Kafka is ready
while ! check_kafka_connection; do
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Kafka is not ready, waiting 5 seconds..."
  sleep 5
done

echo "$(date '+%Y-%m-%d %H:%M:%S') - Kafka is ready, starting topic creation"

# Create topics
for topic in "${TOPICS[@]}"; do
  echo "Creating topic '$topic'..."
  kafka-topics --bootstrap-server "$KAFKA_BROKER" --create --topic "$topic" --partitions 1 --replication-factor 1
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Topic '$topic' created"
  sleep 2
done

echo "$(date '+%Y-%m-%d %H:%M:%S') - Topic creation complete"