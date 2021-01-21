source /usr/share/zsh/share/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle git-flow
antigen bundle pip
antigen bundle command-not-found
antigen bundle docker
antigen bundle history-substring-search
antigen bundle history
antigen bundle vi-mode
antigen bundle pyenv
antigen bundle tmux
antigen bundle fzf
antigen bundle zsh-interactive-cd

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle "MichaelAquilina/zsh-autoswitch-virtualenv"

antigen bundle thewtex/tmux-mem-cpu-load

# Load the theme.
antigen theme robbyrussell


# Tell Antigen that you're done.
antigen apply

# VTE terminal fix
# https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

## Alias
alias :q=exit
alias :Q=:q
alias :q!=:q
alias :Q!=:q
alias :wq=:q
alias Wq=:q

alias :e=nvim
alias :E=:e
alias vi=:e
alias vim=:e

export VISUAL=nvim
export EDITOR="$VISUAL"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:$HOME/.local/bin

#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
#refer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
    #export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

if type exa &> /dev/null; then
    alias ls=exa
fi

if type bat &> /dev/null; then
    alias cat=bat
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1


function list_all() {
  emulate -L zsh
  ls -l
}
chpwd_functions=(${chpwd_functions[@]} "list_all")


# fix bad colors
LS_COLORS='ow=01;36;40'
export LS_COLORS 

function _set_cursor() {
    if [[ $TMUX = '' ]]; then
      echo -ne $1
    else
      echo -ne "\ePtmux;\e\e$1\e\\"
    fi
}

# Remove mode switching delay.
KEYTIMEOUT=5

function _set_block_cursor() { _set_cursor '\e[2 q' }
function _set_beam_cursor() { _set_cursor '\e[5 q' }

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
      _set_block_cursor
  else
      _set_beam_cursor
  fi
}
zle -N zle-keymap-select
# ensure beam cursor when starting new terminal
precmd_functions+=(_set_beam_cursor) #
# ensure insert mode and beam cursor when exiting vim
zle-line-init() { zle -K viins; _set_beam_cursor }
zle-line-finish() { _set_block_cursor }
zle -N zle-line-finish

if [[ $TERM == "xterm-kitty" ]]; then
    alias ssh="TERM='xterm-256color' ssh"
fi

#compdef toggl
_toggl() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _TOGGL_COMPLETE=complete-zsh  toggl)
}
if [[ "$(basename -- ${(%):-%x})" != "_toggl" ]]; then
  compdef _toggl toggl
fi
