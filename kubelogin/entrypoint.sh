#!/bin/sh

set -e

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=us-east-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

# Capture output
output=$( sh -c "aws eks update-kubeconfig --name ${AWS_EKS_CLUSTER}" )

KUBE_CONFIG=$(cat $HOME/.kube/config | base64)

echo "::set-output name=kubeconfig::${KUBE_CONFIG}"

# Preserve output for consumption by downstream actions
echo "$output" > "${HOME}/${GITHUB_ACTION}.${AWS_DEFAULT_OUTPUT}"

# Write output to STDOUT
echo "$output"