#!/bin/bash -e
#
# Build Node.js Docker images for multiple versions
#
# Usage example:
#   export VERS="18.20.8 20.19.5 22.20.0 24.10.0"
#   ./build-node.sh
#
# Or use auto-discovery:
#   ./build-node.sh --auto 18 20 22 24
#   ./build-node.sh --auto 18 20 22 24 --dry-run
#
# The script will build both Alpine and Debian-based images for each version specified.
#

# Function to display help message
show_help() {
    local exit_code=${1:-0}
    local error_msg=${2:-}

    if [[ -n "$error_msg" ]]; then
        echo "Error: $error_msg"
        echo ""
    fi

    echo "Build Node.js Docker images for multiple versions"
    echo ""
    echo "Usage examples:"
    echo "  # Manual version specification:"
    echo "  export VERS=\"18.20.8 20.19.5 22.20.0 24.10.0\""
    echo "  ./build-node.sh"
    echo ""
    echo "  # Auto-discovery of latest versions:"
    echo "  ./build-node.sh --auto 18 20 22 24"
    echo "  ./build-node.sh -a 18 20 22 24"
    echo ""
    echo "  # Dry-run mode (shows what would be built without building):"
    echo "  ./build-node.sh --auto 18 20 22 24 --dry-run"
    echo "  ./build-node.sh -a 18 20 22 24 -d"
    echo ""
    echo "The script will build both Alpine and Debian-based images for each version specified."
    exit "$exit_code"
}

# Function to fetch latest patch version for a given major version from Docker Hub
get_latest_version() {
    local major=$1
    local api_url="https://hub.docker.com/v2/repositories/library/node/tags"

    echo "Fetching latest version for Node.js ${major}.x..." >&2

    # Use the name filter to get tags starting with the major version
    # Then filter for exact matches and get the latest
    local latest=$(curl -s "${api_url}?page_size=50&name=${major}." | \
        jq -r '.results[].name' | \
        grep -E "^${major}\.[0-9]+\.[0-9]+$" | \
        sort -V | \
        tail -n 1)

    if [[ -z "$latest" ]]; then
        echo "Error: Could not find any version for Node.js ${major}.x" >&2
        return 1
    fi

    echo "$latest"
}

# Parse command line arguments
AUTO_MODE=false
DRY_RUN=false
AUTO_VERSIONS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help 0
            ;;
        -a|--auto)
            AUTO_MODE=true
            shift
            # Collect version numbers until we hit another flag or end of args
            while [[ $# -gt 0 ]] && [[ ! "$1" =~ ^- ]]; do
                AUTO_VERSIONS+=("$1")
                shift
            done
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            show_help 1 "Unknown option: $1"
            ;;
    esac
done

# Handle --auto mode
if [[ "$AUTO_MODE" == true ]]; then
    if [[ ${#AUTO_VERSIONS[@]} -eq 0 ]]; then
        show_help 1 "No major versions specified for auto-discovery. Example: ./build-node.sh --auto 18 20 22 24"
    fi

    # Check if jq and curl are available
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is required for --auto mode. Install it with: brew install jq"
        exit 1
    fi

    if ! command -v curl &> /dev/null; then
        echo "Error: curl is required for --auto mode."
        exit 1
    fi

    echo "Auto-discovering latest versions for Node.js major versions: ${AUTO_VERSIONS[*]}"
    echo ""

    VERS=""
    for major in "${AUTO_VERSIONS[@]}"; do
        latest=$(get_latest_version "$major")
        if [[ $? -eq 0 ]]; then
            echo "Found: Node.js ${latest}"
            VERS="${VERS} ${latest}"
        else
            echo "Skipping Node.js ${major}.x due to error"
        fi
    done

    VERS=$(echo "$VERS" | xargs)  # Trim whitespace

    if [[ -z "$VERS" ]]; then
        echo ""
        echo "Error: No versions found"
        exit 1
    fi

    echo ""
    echo "Versions to build: $VERS"
    echo ""

    if [[ "$DRY_RUN" == true ]]; then
        echo "=== DRY RUN MODE ==="
        echo ""
        for ver in $VERS; do
            major=$(echo $ver | awk -F \. '{ print $1 }')
            echo "Would build Node.js ${ver}:"
            echo "  - Alpine base: ${ver}-alpine (manifest: ${major}-alpine)"
            echo "  - Alpine standard: ${ver}-alpine (manifest: ${major}-alpine)"
            echo "  - Alpine builder: ${ver}-alpine (manifest: ${major}-alpine)"
            echo "  - Debian base: ${ver}-debian (manifest: ${major}-debian)"
            echo ""
        done
        echo "=== END DRY RUN ==="
        exit 0
    fi
fi

# Dynamically determine the repository root directory
# Use realpath if available, otherwise fall back to pwd-based resolution
if command -v realpath &> /dev/null; then
    SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
else
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
ROOTDIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

BASE_ALPINE=alpine
BASE_DEBIAN=trixie-slim
BASE_PREFIX=
VERS=${VERS:-}

# Check if VERS is empty
if [[ -z "$VERS" ]]; then
    show_help 1 "VERS environment variable is not set or is empty."
fi

function auth() {
    aws ecr-public get-login-password --region us-east-1 | \
        docker login --username AWS --password-stdin public.ecr.aws/unocha
}

function build_node_base_alpine() {
    ver=$1
    major=$2
    npm=$3
    yarn=$4

    cd ${ROOTDIR}/nodejs/base

    make itso UPSTREAM=${ver}-${BASE_ALPINE} VERSION=${ver}-alpine \
        EXTRAOPTIONS="--no-cache --build-arg NODE_VERSION=v${ver} \
        --build-arg NPM_VERSION=${npm} --build-arg YARN_VERSION=${yarn}" \
        MANIFEST_VERSION=${major}-alpine
}

function build_node_alpine() {
    ver=$1
    major=$2

    cd ${ROOTDIR}/nodejs

    make itso UPSTREAM=${ver}-alpine VERSION=${ver}-alpine \
        EXTRAOPTIONS="--no-cache" \
        MANIFEST_VERSION=${major}-alpine
}

function build_node_builder() {
    ver=$1
    major=$2

    cd ${ROOTDIR}/nodejs/builder
    make itso UPSTREAM=${ver}-alpine VERSION=${ver}-alpine \
        EXTRAOPTIONS="--no-cache" \
        MANIFEST_VERSION=${major}-alpine
}

function build_node_base_debian() {
    ver=$1
    major=$2
    npm=$3
    yarn=$4

    cd ${ROOTDIR}/nodejs/debian-base

    make itso UPSTREAM=${ver}-${BASE_DEBIAN} VERSION=${ver}-debian \
        EXTRAOPTIONS="--no-cache --build-arg NODE_VERSION=v${ver} \
        --build-arg NPM_VERSION=${npm} --build-arg YARN_VERSION=${yarn}" \
        MANIFEST_VERSION=${major}-debian
}

for ver in $VERS; do

    ### Alpine based

    major=$(echo $ver | awk -F \. '{ print $1 }')
    npm=$(docker run --rm --entrypoint sh node:${ver}-${BASE_ALPINE} -c "npm --version")
    yarn=$(docker run --rm --entrypoint sh node:${ver}-${BASE_ALPINE} -c "yarn --version")

    echo -en "\nBuilding alpine based version:\nalpine: ${BASE_ALPINE}\nnode:$ver\nnode major: $major\nnpm: $npm\nyarn: $yarn\n"

    # nodejs-base alpine
    auth && build_node_base_alpine $ver $major $npm $yarn

    # nodejs alpine
    auth && build_node_alpine $ver $major

    # nodejs alpine builder
    auth && build_node_builder $ver $major

    ### Debian based

    major=$(echo $ver | awk -F \. '{ print $1 }')
    npm=$(docker run --rm --entrypoint sh node:${ver}-${BASE_DEBIAN} -c "npm --version")
    yarn=$(docker run --rm --entrypoint sh node:${ver}-${BASE_DEBIAN} -c "yarn --version")

    echo -en "\nBuilding debian based version:\ndebian: ${BASE_DEBIAN}\nnode:$ver\nnode major: $major\nnpm: $npm\nyarn: $yarn\n"

    # nodejs-base debian
    auth && build_node_base_debian $ver $major $npm $yarn
done

echo ""
echo "=== Node.js builds completed ==="
echo ""
echo "Note: debian-snap-base is built separately using build-snap-base.sh"
