# Kubernetes Exports
export KUBECONFIG=/Users/cphillips/.kube/config
export KUBERNETES_PROVIDER=aws
export KUBE_EDITOR="vim"

# Vault Exports
export VAULT_ADDR=https://vault.main.prod.2u.com:8200/
export VAULT_CACERT=$HOME/.certs/vault-ca.pem

# Ansible Exports
export ANSIBLE_INVENTORY=/Users/cphillips/.ansible/aws_ec2.yml
export ANSIBLE_NOCOWS=1

# Causes issues since High Sierra with forking processes.
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
