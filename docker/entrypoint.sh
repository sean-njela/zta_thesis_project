#!/bin/sh 

# Exit immediately if a command exits with a non-zero status
set -e

echo "🔧 Starting entrypoint script..."

echo "🚀 Starting main application: $@"

exec "$@"
