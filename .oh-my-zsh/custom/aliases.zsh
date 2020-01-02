alias ans="source ~/virtualenv/ansible/bin/activate"
alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"
alias dv2="source ~/virtualenv/default2.7/bin/activate"
alias dv3="source ~/virtualenv/default3/bin/activate"
alias ecr_login="aws ecr get-login --no-include-email --region us-west-2"
alias g="/usr/bin/git"
alias kc="kubectl"
alias kube_login="~cphillips/k8s-login.py"
alias lower="python -c '\''import sys; string = sys.argv[1]; string.lower()'"
alias servethis="python -m SimpleHTTPServer $1"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias tf="terraform"
alias tfp="terraform plan"

# Molecule aliases
alias m='molecule'
alias mc='molecule converge'
alias ml='molecule lint'
alias mt='molecule test'
alias mlog='molecule login'

# Ansible
alias atag='/Users/cphillips/work/repos/ops-tools/ansible-role-tags/latest_role_tags.py'
