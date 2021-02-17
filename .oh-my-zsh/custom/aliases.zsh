# Misc
alias login="2u-vpn c && /usr/local/bin/_login"
alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"
alias lower="python -c '\''import sys; string = sys.argv[1]; string.lower()'"
alias sc="shellcheck"
alias servethis="python -m http.server $1"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias ecr_login="aws ecr get-login --no-include-email --region us-west-2"

# Virtualenvs
alias ans="source ~/virtualenv/ansible/bin/activate"
alias ans2="source ~/virtualenv/ansible2/bin/activate"
alias ans3="source ~/virtualenv/ansible-2.10/bin/activate"
alias dv2="source ~/virtualenv/default2.7/bin/activate"
alias dv3="source ~/virtualenv/default3/bin/activate"

# k8s
alias kc="kubectl"
alias kube_login="~cphillips/k8s-login.py"


# Terraform
alias tf="/usr/local/bin/terraform"
alias tfp="/usr/local/bin/terraform plan"
alias tfw="/usr/local/bin/terraform workspace"
alias tfws="/usr/local/bin/terraform workspace select"

# Molecule aliases
alias m='molecule'
alias mc='molecule converge'
alias ml='molecule lint'
alias mt='molecule test'
alias mlog='molecule login'

# Ansible
alias atag='/Users/cphillips/work/repos/ops-tools/ansible-role-tags/latest_role_tags.py'

# Git
alias g="/usr/bin/git"

# Github CLI
alias ghprc='/usr/local/bin/gh pr create'

# Jenkins Testing
alias jpv='~/work/repos/ops-tools/jenkins-pipeline-validator/validate.sh'

