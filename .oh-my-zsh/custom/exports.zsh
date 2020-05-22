# Golang
export GOPATH=$HOME/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Kubernetes Exports
export KUBECONFIG=${HOME}/.kube/config
export KUBERNETES_PROVIDER=aws
export KUBE_EDITOR="vim"

# Ansible Exports
export ANSIBLE_INVENTORY=${HOME}/.ansible/aws_ec2.yml
export ANSIBLE_NOCOWS=1
# Used because of ansible...
# Without it you occasionally get an Error about Worker in a Dead State
export NO_PROXY=*

if [[ $(uname) == 'Darwin' ]]; then
  # Causes issues since High Sierra with forking processes.
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

# Pager Shenanigans
export AWS_PAGER=""

