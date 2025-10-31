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
alias hippo-start="b -DskipTests && mvn -P cargo.run -Drepo.path=/tmp/hippo-repo -Dcargo.jvm.args=-Xmx4g"
alias hippo-clean-start="rm -rf /tmp/hippo-repo && hippo-start"
alias hippo-debug-start="b -DskipTests && mvn -P cargo.run -Dcargo.debug.suspend=y -Drepo.path=/tmp/hippo-repo -Dcargo.jvm.args=-Xmx4g"
alias hippo-clean-debug-start="rm -rf /tmp/hippo-repo && hippo-debug-start"


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
#export PATH=/opt/homebrew/bin:$PATH

#export PATH="$PATH:/Applications/IntelliJ IDEA CE.app/Contents/MacOS"

export PATH=$HOME/.krew/bin:$PATH

kaas () {
  echo "Fetching any new clusters"
  for sub in $(az account list -o tsv --query "[].name" 2>/dev/null | grep eep-kaas); do
    # Get all AKS clusters available in subscription
    az aks list --subscription "$sub" -o tsv --query "[].[name, resourceGroup]" | while read -r name rsg; do
      if [[ ! $(kubectl config get-contexts --output="name" | grep "$name") ]]; then
        az aks get-credentials --subscription "$sub" -n "$name" -g "$rsg" --overwrite-existing
      fi
    done
  done

  echo "Converting kube config with kubelogin"
  kubelogin convert-kubeconfig -l azurecli

  if [[ "$1" == "purge" ]]; then
    echo "Purging unreachable clusters"
    for context in $(kubectl config get-contexts --output="name" | egrep "^(aks|k8s)"); do
      kubectl get nodes --context "$context" 1>/dev/null 2>&1 || kubectl config delete-context "$context"
    done
  fi
}

export PATH="/Users/lvanderveekens/.rd/bin:$PATH"

export PATH="$(pyenv root)/shims:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/lvanderveekens/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
alias lzd='lazydocker'
