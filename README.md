# Nitro Private Inference

Run Ollama in AWS Nitro Enclaves with verifiable attestation, enabling private AI inference with end-to-end verification.

## Release Artifacts

Each release provides three key verifiable artifacts, that are available in the Github Releases section. Below are examples from the [v0.0.4](https://github.com/tinfoilanalytics/nitro-private-inference-image/releases/tag/v0.0.4) release:

1. Enclave Image File (EIF):

```bash
curl -L https://static.tinfoil.sh/tinfoil-enclave-ollama-v0.0.4.eif -o tinfoil-enclave.eif
```

2. Measurements File:

```bash
{
  "PCR0": "0b094eb7ef7ebe70bf9146ada6d409f558e5c087eabcb873f87aa3d84a976347a2ee1ef55e63bfb182ad73c457ee2f9b",
  "PCR1": "4b4d5b3661b3efc12920900c80e126e4ce783c522de6c02a2a5bf7af3a2b9327b86776f188e4be1c1c404a129dbda493",
  "PCR2": "b40be6de88fda829061f696371d1f68c47b6e514de0d25bbea1a7ecbb57fe58f425b1a16071e6ea1c9553321ebf8749f"
}
```

3. Sigstore Attestation
    - Verifiable at [Rekor Log #150364935](https://search.sigstore.dev/?logIndex=150364935)
    - Links source code to built artifacts


## Security

- Build-time attestation via Sigstore & GitHub OIDC
- Runtime attestation via AWS Nitro Hardware
- Verifiable PCR measurements at both build and runtime
