# Misc
alias login="2u-vpn c && /usr/local/bin/_login"
alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"
alias lower="python -c '\''import sys; string = sys.argv[1]; string.lower()'"
alias sc="shellcheck"
alias servethis="python3 -m http.server $1"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias ecr_login="aws ecr get-login --no-include-email --region us-west-2"
alias tmat="tmux attach -t gif || tmux new -s gif"
#alias asciicast2gif='docker run --rm -v $PWD:/data asciinema/asciicast2gif'
alias a2g="/opt/homebrew/bin/asciicast2gif"
alias cdm='cd $GO2UPATH/mole'
alias c7n='$(which custodian)'

# Virtualenvs
alias ans="source ~/virtualenv/ansible/bin/activate"
alias c7na="source ~/virtualenv/c7n/bin/activate"
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

# Go
alias gob="go build"

# Git
alias g="/usr/bin/git"

# Github CLI
alias ghprc='$(which gh) pr create'

# Jenkins Testing
alias jpv='~/work/repos/ops-tools/jenkins-pipeline-validator/validate.sh'

# 2U Aliases
#
# Ansible
alias atag='/Users/cphillips/work/repos/ops-tools/ansible-role-tags/latest_role_tags.py'
alias ssmh='python3 /Users/cphillips/work/repos/ops-tools/ssm-session-finder/session_finder.py'


