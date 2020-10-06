#!/bin/bash
set -eu

if [ $1 = "-h" -o $1 = "--help" ]; then
cat <<EOF
Decrypt from ciphertext to plaintext with using the KMS of GCP

Usage:
  ./decrypt_sealed_secret_key.sh [env]
EOF
  exit 0
fi

scripts_dir="$(dirname "$0")"
$scripts_dir/enable_env_name.sh $1

gcloud config set project gitops-sample-$1
gcloud kms decrypt \
    --project=gitops-sample-$1 \
    --location=global \
    --keyring=api \
    --key=sealed-secret \
    --ciphertext-file=sealed-secrets-key-$1.yaml.enc \
    --plaintext-file=sealed-secrets-key-$1.yaml
