# AWS
alias eks_nodes='~/personal/python-snippets/list_instances.py'

# GCP
alias gcp='$(which gcloud)'

# Misc

alias a2g="/opt/homebrew/bin/asciicast2gif"
alias c7n='$(which custodian)'
alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"
alias ecr_login="aws ecr get-login --no-include-email --region us-west-2"
alias j2y="json_to_yaml"
alias login="2u-vpn c && /usr/local/bin/_login"
alias lower="python -c '\''import sys; string = sys.argv[1]; string.lower()'"
alias opl="op signin"
alias sc="shellcheck"
alias servethis="python3 -m http.server $1"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias tmat="tmux attach -t gif || tmux new -s gif"
alias yl="/opt/homebrew/bin/yamllint"

# Virtualenvs
alias ans="source ~/virtualenv/ansible/bin/activate"
alias c7na="source ~/virtualenv/c7n/bin/activate"
alias dv3="source ~/virtualenv/default3/bin/activate"

# k8s
alias kc="kubectl"
alias kube_login="~cphillips/k8s-login.py"


# Terraform
alias tf="/opt/homebrew/bin/terraform"
alias tfi="/opt/homebrew/bin/terraform import"
alias tfp="/opt/homebrew/bin/terraform plan"
alias tfw="/opt/homebrew/bin/terraform workspace"
alias tfws="/opt/homebrew/bin/terraform workspace select"

# Molecule aliases
alias m='molecule'
alias mc='molecule converge'
alias ml='molecule lint'
alias mlog='molecule login'
alias mt='molecule test'

# Go
alias gob="go build"

# Git
alias g="/usr/bin/git"
alias gmd="$(which gh) pr merge -r -d && /usr/bin/git up"
alias gsoft="/usr/bin/git reset --soft"

# Github CLI
alias ghprc='$(which gh) pr create'
alias ghprm='$(which gh) pr merge -rd'
alias prm=echo "$(which gh pr create --fill)"

# Jenkins Testing
alias jpv='~/work/repos/ops-tools/jenkins-pipeline-validator/validate.sh'
