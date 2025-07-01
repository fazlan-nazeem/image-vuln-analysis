#!/bin/bash

# Check for input file
if [ -z "$1" ]; then
  echo "Usage: $0 <alpine-versions-file>"
  echo "Example: $0 alpine_versions.txt"
  exit 1
fi

FILE="$1"

# Check if Docker Scout is available
if ! command -v docker scout &> /dev/null; then
  echo "❌ Docker Scout CLI is not installed. Please install it: https://docs.docker.com/scout/install/"
  exit 1
fi

# Check if file exists
if [ ! -f "$FILE" ]; then
  echo "❌ File not found: $FILE"
  exit 1
fi

# Read and scan each image
while IFS= read -r IMAGE; do
  [[ -z "$IMAGE" || "$IMAGE" =~ ^# ]] && continue

  echo "📥 Pulling image $IMAGE..."
  docker pull "$IMAGE"

  echo "🔎 Scanning $IMAGE with Docker Scout..."
  docker scout cves "$IMAGE" --only-severity critical,high || {
    echo "⚠️ Failed to scan $IMAGE"
    continue
  }

  echo "----------------------------------------"
done < "$FILE"
