# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ulimit -n 1024

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh
export ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ $(uname) == 'Darwin' ]]; then
  eval "$(ssh-agent -s)"
  ssh-add  --apple-use-keychain ${HOME}/.ssh/id_rsa
fi

# Config Settings
CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="mm/dd/yyyy"
PROMPT_EOL_MARK=''

# ASDF
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Plugins
plugins=(
	ansible
    asdf
	git
	virtualenv
	)


# PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/sbin:${GOPATH}/workspace:${GOPATH}/bin:/usr/local/opt/openssl/bin:$PATH"

# Sourcing
source ${ZSH}/oh-my-zsh.sh
source <(kubectl completion zsh)
eval "$(op completion zsh)"; compdef _op op
eval "$(thefuck --alias)"


[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Misc
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

autoload -U +X bashcompinit && bashcompinit
config='/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}'
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


if [ -e ${HOME}/.nix-profile/etc/profile.d/nix.sh ]; then . ${HOME}/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

export OL_MFA=0
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/user85520017/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/user85520017/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/user85520017/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/user85520017/tmp/google-cloud-sdk/completion.zsh.inc'; fi

