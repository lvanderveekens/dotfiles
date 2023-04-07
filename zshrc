export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(kubectl git)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/tools/flutter/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# Personal aliases
alias b="mvn clean install"
alias vim="nvim"

# kube-ps1
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lvanderveekens/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lvanderveekens/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lvanderveekens/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lvanderveekens/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


source /Users/lvanderveekens/.docker/init-zsh.sh || true # Added by Docker Desktop

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# env vars
export KUBE_EDITOR="/opt/homebrew/bin/nvim"
