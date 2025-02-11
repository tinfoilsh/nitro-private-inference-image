#!/bin/bash

set -e

LATEST_TAG=$(curl -s https://api.github.com/repos/tinfoilsh/nitro-private-inference-image/releases | jq -r ".[0].tag_name")
echo "Downloading enclave $LATEST_TAG"

curl -LO "https://enclave-images.tinfoil.sh/tinfoil-enclave-ollama-$LATEST_TAG.eif"

echo "Terminating enclave"
nitro-cli terminate-enclave --all

echo "Running enclave"
nitro-cli run-enclave \
    --eif-path "tinfoil-enclave-ollama-$LATEST_TAG.eif" \
    --memory 24G \
    --cpu-count 6

sleep 2
echo "Restarting vsock proxy"
sudo systemctl restart vsock-proxy

echo "Done"

nitro-cli describe-enclaves
