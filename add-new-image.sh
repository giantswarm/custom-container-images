#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# setup

owners=""
image=""
flavour="default"
base_image=""

# usage

function usage() {
  echo "Usage: $0 [option...]"
  echo ""
  echo "  -o    Owners according to CODWEONERS file format, e.g. @user or @giantswarm/team-name."
  echo "  -i    Image name that will be used for the built artifact."
  echo "  -f    Flavour name for the given image, defaults to 'default' if not set."
  echo "  -b    Base image to use in the generated Dockerfile, e.g. quay.io/alpine:3.16.2. Please always fix the version and/or SHA256!"
  echo ""
  echo "Example usage:"
  echo ""
  echo "  $0 -o \"@giantswarm/team-honeybadger\" -i \"kratix\" -b \"gsoci.azurecr.io/giantswarm/kratix-base-cli:0.1.0\""
  echo "  $0 -o \"@giantswarm/team-honeybadger\" -i \"alpine\" -f \"kubectl\" -b \"gsoci.azurecr.io/giantswarm/kratix-base-cli:0.1.0\""
}

# arguments

while getopts "ho:i:f:b:" opt; do
  case $opt in
    h)
      usage
      exit 0
      ;;
    o)
      owners="$OPTARG"
      ;;
    i)
      image="$OPTARG"
      ;;
    f)
      flavour="$OPTARG"
      ;;
    b)
      base_image="$OPTARG"
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

# post setup

if [[ -z "$owners" ]]; then
  echo "Owners must be set with -o!"
  exit 1;
fi

if [[ -z "$image" ]]; then
  echo "Image name must be set with -i!"
  exit 1;
fi

if [[ -z "$base_image" ]]; then
  echo "Base image must be set with -b!"
  exit 1;
fi

# main

## image directory

mkdir -p "${SCRIPT_DIR}/${image}"

## dockerfile

dockerfile="${image}/${flavour}.dockerfile"

if [[ -f "${SCRIPT_DIR}/${dockerfile}" ]]; then
  echo "Image '${image}' with flavour '${flavour}' already exists at: '${dockerfile}', bailing out..."
  exit 1
fi

cat > "${SCRIPT_DIR}/${dockerfile}" <<EOF
FROM --platform=linux/amd64 ${base_image}

EOF

echo "✔ Created dockerfile at: ${dockerfile}"

## pipeline

pipeline_file=".circleci/${image}.yml"

if [[ ! -f "${SCRIPT_DIR}/${pipeline_file}" ]]; then
  cat > "${SCRIPT_DIR}/${pipeline_file}" <<EOF
version: 2.1
orbs:
  architect: giantswarm/architect@5.8.0

workflows: {}
EOF
fi

yq -i ".workflows.build-${image}-${flavour}.jobs = []" "${SCRIPT_DIR}/${pipeline_file}"
yq -i ".workflows.build-${image}-${flavour}.jobs[0].architect/push-to-registries.context = \"architect\"" "${SCRIPT_DIR}/${pipeline_file}"
yq -i ".workflows.build-${image}-${flavour}.jobs[0].architect/push-to-registries.name = \"push-to-registries\"" "${SCRIPT_DIR}/${pipeline_file}"
yq -i ".workflows.build-${image}-${flavour}.jobs[0].architect/push-to-registries.git-tag-prefix = \"${image}-${flavour}\"" "${SCRIPT_DIR}/${pipeline_file}"
yq -i ".workflows.build-${image}-${flavour}.jobs[0].architect/push-to-registries.tag-suffix = \"-${flavour}\"" "${SCRIPT_DIR}/${pipeline_file}"
yq -i ".workflows.build-${image}-${flavour}.jobs[0].architect/push-to-registries.image = \"giantswarm/${image}\"" "${SCRIPT_DIR}/${pipeline_file}"
yq -i ".workflows.build-${image}-${flavour}.jobs[0].architect/push-to-registries.dockerfile = \"./${dockerfile}\"" "${SCRIPT_DIR}/${pipeline_file}"
yq -i ".workflows.build-${image}-${flavour}.jobs[0].architect/push-to-registries.context = \"architect\"" "${SCRIPT_DIR}/${pipeline_file}"
yq -i ".workflows.build-${image}-${flavour}.jobs[0].architect/push-to-registries.build-context = \"${image}\"" "${SCRIPT_DIR}/${pipeline_file}"

echo "✔ Added workflow to: ${pipeline_file}"

## codeowners

if grep "^${pipeline_file}" CODEOWNERS; then
  sed -i "s;^${pipeline_file}.*;& ${owners};" CODEOWNERS
else
  cat >>"${SCRIPT_DIR}/CODEOWNERS" <<EOF

${pipeline_file} ${owners}
EOF
fi

cat >>"${SCRIPT_DIR}/CODEOWNERS" <<EOF
${dockerfile} ${owners}
EOF

echo "✔ Updated CODEOWNERS file."
