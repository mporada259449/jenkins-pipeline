#!/bin/sh

set -e
export TOKEN="${VAULT_DEV_ROOT_TOKEN_ID}"
export VAULT_ADDR="http://127.0.0.1:8200"
VAULT_DIR=/vault

echo "Starting Vault server in dev mode"
cd $VAULT_DIR
cp external/vault.hcl config/vault.hcl
vault server -dev > vault.logs 2>&1 &
VAULT_PID=$!

retry=0
while  ! nc -z 127.0.0.1 8200 && [[ $retry -le 9 ]]; do
    echo "Waiting for Vault, retry: $retry"
    retry=$(($retry+1)) 
    sleep 1
done

if [[ $retry -eq 10 ]]; then
    echo "Vault server didn't start"
    exit 1
fi

echo "Logging as a root"
vault login -method=token "${TOKEN}"

echo "Creating new secret engine"
vault secrets enable -path=secrets/jenkins -version=2 kv

echo "Creating SSH secrets"
cat /data/.ssh/ssh-jenkins-read | vault kv put -mount=secrets/jenkins ssh-key key=-

echo "Enable AppRole auth"
vault auth enable approle

echo "Loading policy"
vault policy write approle-policy external/policy.hcl

echo "Creating approle"
vault write /auth/approle/role/jenkins-role token_policies=approle-policy

echo "Gethering info about AppRole"
ROLE_ID=$(vault read -field=role_id auth/approle/role/jenkins-role/role-id)
SECRET_ID=$(vault write -f -field=secret_id auth/approle/role/jenkins-role/secret-id)

vault kv put -mount=secrets/jenkins approle role=$ROLE_ID secret=$SECRET_ID

wait $VAULT_PID
