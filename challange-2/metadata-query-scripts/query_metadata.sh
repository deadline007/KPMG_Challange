#!/bin/bash
INSTANCE_NAME="test"
PROJECT_ID="test-123"
ZONE="us-central1-a"
OUTPUT_FILE="metadata.json"

gcloud compute instances describe test --project=solution-kit-1 --zone=us-central1-a --format=json > "OUTPUT_FILE"

echo "Metadat of $INSTANCE_NAME instance saved to $OUTPUT_FILE"