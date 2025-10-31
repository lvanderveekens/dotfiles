# Setup fzf
# ---------

export FZF_TMUX_HEIGHT="100%"

if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null


# Key bindings
# ------------
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# CTRL-F 
__ctrlfsel() {
  local cmd="${FZF_CTRL_F_COMMAND:-"command find -L $HOME/code -maxdepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print \
    -o -type l -print 2> /dev/null"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS-} ${FZF_CTRL_F_OPTS-}" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  return $ret
}

fzf-ctrl-f-widget() {
  #local dir_path=$(__ctrlfsel)
  # trim leading and trailing whitespace
  #dir_path=$(echo $dir_path | xargs) 

  #if [[ -n $dir_path ]]
  #then
  #    tmux new-session -A -s $(basename $dir_path) -n $(basename $dir_path) -c $dir_path
  #fi
  LBUFFER="${LBUFFER}$(__ctrlfsel)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N            fzf-ctrl-f-widget
bindkey -M emacs '^F' fzf-ctrl-f-widget
bindkey -M vicmd '^F' fzf-ctrl-f-widget
bindkey -M viins '^F' fzf-ctrl-f-widget
