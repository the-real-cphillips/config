# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ulimit -n 1024

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh
export ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ $(uname) == 'Darwin' ]]; then
  eval "$(ssh-agent -s)"
  ssh-add -K ${HOME}/.ssh/id_rsa
fi

# Config Settings
CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"

# Plugins
plugins=(
	ansible
	git
	virtualenv
	)


# PATH
export PATH="/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/sbin:${GOPATH}/workspace:${GOPATH}/bin:/usr/local/opt/openssl/bin:/Users/cphillips/work/repos/ops-tools/r53_lookup:$PATH"

# Sourcing
source ${ZSH}/oh-my-zsh.sh
source <(kubectl completion zsh)

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Misc
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault
eval $(thefuck --alias)
config='/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}'
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


