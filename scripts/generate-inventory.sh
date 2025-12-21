#!/usr/bin/env bash
set -e

# Absolute path to the repo root (parent of scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd | tee /dev/tty)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd | tee /dev/tty)"

IP=$(terraform -chdir="$REPO_ROOT/infra" output -raw elastic_ip)

if [[ -z "$IP" ]]; then
  echo "ERROR: elastic_ip output is empty"
  exit 1
fi

cat > "$REPO_ROOT/ansible/inventory.ini" <<EOF
[todo_app]
$IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/sod-rsakeypair-sboiciuc.pem
EOF

echo "Inventory generated with IP: $IP"
