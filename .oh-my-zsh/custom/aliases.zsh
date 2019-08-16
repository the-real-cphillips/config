alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias tf="terraform_0.12"
alias tf11="terraform"
alias dv2="source ~/virtualenv/default2.7/bin/activate"
alias dv3="source ~/virtualenv/default3/bin/activate"
alias ans="source ~/virtualenv/ansible/bin/activate"
alias servethis="python -m SimpleHTTPServer $1"
alias kc="kubectl"
alias lower="python -c '\''import sys; string = sys.argv[1]; string.lower()'"
alias ecr_login="aws ecr get-login --no-include-email --region us-west-2"
alias tfp="terraform plan"
alias kube_login="~cphillips/k8s-login.py"
alias config="/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"
alias g="/usr/bin/git"

# Molecule aliases
alias m='molecule'
alias ml='molecule lint'
alias mt='molecule test'
