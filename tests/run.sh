#!/usr/bin/env bash
# Test entry point, called by scripts/validate.sh. Runs every Maven test offline.
# One-time setup with network access: mvn -q dependency:go-offline test
set -euo pipefail
cd "$(dirname "$0")/.."
mvn -o -q test
