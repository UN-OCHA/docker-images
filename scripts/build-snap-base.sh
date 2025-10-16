#!/bin/bash -e
#
# Build debian-snap-base Docker image
#
# Usage example:
#   ./build-snap-base.sh
#   ./build-snap-base.sh 22
#   ./build-snap-base.sh 24
#
# Default: Uses Node.js major version 22
#

# Function to display help message
show_help() {
    local exit_code=${1:-0}
    local error_msg=${2:-}

    if [[ -n "$error_msg" ]]; then
        echo "Error: $error_msg"
        echo ""
    fi

    echo "Build debian-snap-base Docker image"
    echo ""
    echo "Usage examples:"
    echo "  # Build with default Node.js 22:"
    echo "  ./build-snap-base.sh"
    echo ""
    echo "  # Build with specific major version:"
    echo "  ./build-snap-base.sh 22"
    echo "  ./build-snap-base.sh 24"
    echo ""
    echo "Arguments:"
    echo "  \$1 - Major Node.js version (e.g., 22, 24) - default: 22"
    exit "$exit_code"
}

# Handle -h or --help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help 0
fi

# Dynamically determine the repository root directory
if command -v realpath &> /dev/null; then
    SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
ROOTDIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Set default to Node.js 22
MAJOR="${1:-22}"

echo ""
echo "=== Building debian-snap-base ==="
echo "Node.js major version: ${MAJOR}"
echo "Using base image tag: ${MAJOR}-debian"
echo ""

# Authentication function
auth() {
    aws ecr-public get-login-password --region us-east-1 | \
        docker login --username AWS --password-stdin public.ecr.aws/unocha
}

# Build function
build_snap_base_debian() {
    major=$1

    cd ${ROOTDIR}/debian-snap-base

    # Note: This uses the major version as both the version tag and to reference the base image
    # UPSTREAM=${major}-debian refers to public.ecr.aws/unocha/nodejs-base:${major}-debian
    make itso UPSTREAM=${major}-debian VERSION=${major}-debian \
        EXTRAOPTIONS="--no-cache" \
        MANIFEST_VERSION=${major}-debian
}

# Execute build
auth && build_snap_base_debian $MAJOR

echo ""
echo "=== debian-snap-base build completed ==="
echo "Built: public.ecr.aws/unocha/debian-snap-base:${MAJOR}-debian"
echo ""
