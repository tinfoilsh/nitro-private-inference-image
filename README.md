# Nitro Private Inference

```bash
docker run \
    --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(pwd):/output \
    -e DOCKER_IMAGE=ollama-nitro:latest \
    -e EIF_FILE=tinfoil-enclave.eif \
    -e INFO_FILE=tinfoil-enclave-info.json \
    eif-builder:latest
```
