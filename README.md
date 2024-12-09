# Nitro Private Inference

Run Ollama in AWS Nitro Enclaves with verifiable attestation, enabling private AI inference with end-to-end verification.

## Release Artifacts

Each release provides three key verifiable artifacts, that are available in the Github Releases section. Below are examples from the [v0.0.8](https://github.com/tinfoilanalytics/nitro-private-inference-image/releases/tag/v0.0.8) release:

1. Enclave Image File (EIF):

```bash
curl -LO https://enclave-images.tinfoil.sh/tinfoil-enclave-ollama-v0.0.8.eif
```

2. Measurements File:

```bash
{
  "PCR0": "4406a820aa96a103fcd640faa28df6384e33593d3867d84cc59dab7aaccea8897474d4058a317466eaf1234a56cc208e",
  "PCR1": "4b4d5b3661b3efc12920900c80e126e4ce783c522de6c02a2a5bf7af3a2b9327b86776f188e4be1c1c404a129dbda493",
  "PCR2": "c11e9df1617cf330533e45c75cafc2da24b04df4eb0a8668481b1669d31df4a690e8af687855318fb335fb2bbd596ffb"
}
```

3. Sigstore Attestation
    - Verifiable at [Rekor Log #151714739](https://search.sigstore.dev/?logIndex=151714739)
    - Links source code to built artifacts


## Security

- Build-time attestation via Sigstore & GitHub OIDC
- Runtime attestation via an AWS Nitro Enclave
- Verifiable PCR measurements at both build and runtime

## Development

### Creating a new release

To create a new release, push a new tag (semver `vX.X.X`) to this repo. GitHub Actions will build an EIF image and publish a link to the image, it's measurements, and the Sigstore attestation to the [release notes](https://github.com/tinfoilanalytics/nitro-private-inference-image/releases).

### Installation

To prepare a fresh EC2 instance:

```bash
# Install dependencies
sudo dnf install -y git socat docker aws-nitro-enclaves-cli aws-nitro-enclaves-cli-devel
sudo usermod -aG ne ec2-user
sudo usermod -aG docker ec2-user

# Raise resource limits
sudo sed -i 's/^memory.*/memory_mib: 24576/' /etc/nitro_enclaves/allocator.yaml
sudo sed -i 's/^cpu.*/cpu_count: 6/' /etc/nitro_enclaves/allocator.yaml

# Start services
sudo systemctl enable --now docker
sudo systemctl enable --now nitro-enclaves-allocator
```

### Deploying

1. Run the [update script](https://github.com/tinfoilanalytics/nitro-attestation-shim/blob/main/deploy/update.sh) on the AWS Nitro EC2 instance to download the new EIF image and start a new enclave.

2. With the enclave running, start the vsock HTTP proxy: `socat tcp-listen:6000,reuseaddr,fork vsock-connect:16:6000`

If running under systemd, restart the `vsock-proxy` service with `sudo sysrtemctl restart vsock-proxy`
