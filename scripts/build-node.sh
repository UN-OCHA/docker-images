#!/bin/bash -e
#
# Build Node.js Docker images for multiple versions
#
# Usage example:
#   export VERS="18.20.8 20.19.5 22.20.0 24.10.0"
#   ./build-node.sh
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
    echo "Usage example:"
    echo "  export VERS=\"18.20.8 20.19.5 22.20.0 24.10.0\""
    echo "  ./build-node.sh"
    echo ""
    echo "The script will build both Alpine and Debian-based images for each version specified."
    exit "$exit_code"
}

# Handle -h or --help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help 0
fi

# Dynamically determine the repository root directory
SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || realpath "${BASH_SOURCE[0]}")")" && pwd)"
ROOTDIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

BASE_ALPINE=alpine
BASE_DEBIAN=slim
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

function build_snap_base_debian() {
    ver=$1
    major=$2

    cd ${ROOTDIR}/debian-snap-base

    make itso UPSTREAM=${major}-debian VERSION=${ver}-debian \
        EXTRAOPTIONS="--no-cache" \
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

    # debian-snap-base
    auth && build_snap_base_debian $ver $major
done
