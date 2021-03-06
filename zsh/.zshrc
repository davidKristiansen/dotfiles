# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh/share/antigen.zsh

antigen theme romkatv/powerlevel10k

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
# antigen bundle zsh-users/zsh-completion
antigen bundle "MichaelAquilina/zsh-autoswitch-virtualenv"

# antigen bundle thewtex/tmux-mem-cpu-load

# antigen bundle "DarrinTisdale/zsh-aliases-exa"

# antigen bundle "alichtman/zsh-startify"

# Load the theme.
# antigen theme agnoster


# Tell Antigen that you're done.
antigen apply

#export DEFAULT_USER=david
## VTE terminal fix
## https://gnunn1.github.io/tilix-web/manual/vteconfig/
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

export GOPATH=$HOME/.go

export PATH=$PATH:$HOME/.local/bin:$GOROOT/bin

##determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
#refer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
    #export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

if type exa &> /dev/null; then
    alias ls='exa'
    alias l='exa -lbF --git'
    alias ll='exa -lbGF --git'
    alias llm='exa -lbGd --git --sort=modified'
    alias la='exa -lbhga  --git --color-scale'
    alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale'
    alias lS='exa -1'
    alias lt='exa --tree --level=2'
fi

if type bat &> /dev/null; then
    alias cat=bat
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

function list_all() {
  emulate -L zsh
  exa -lbhga --git --color-scale
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
# zsh-startify


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
