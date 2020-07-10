# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# aliases for tools I like and use
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias ls='exa'
alias l='exa -l --color=always --git'
alias ll='exa -l --color=always --git'
alias la='exa -la --color=always --git'
alias todo='nvim $HOME/.TODO.md'
alias journal='nvim $HOME/Documents/journal/$(date "+%d-%m-%y").md'
alias fuck='sudo !!'

function paste() {
    local file=${1:-/dev/stdin}
    curl --data-binary $${file} https://paste.rs
}

# aliases for the kitty terminal
if [[ $TERM == "xterm-kitty" ]]; then
    alias ssh='kitty +kitten ssh'
    alias icat='kitty +kitten icat'
fi

#varius exports
export EDITOR='nvim'
export BAT_THEME='base16'

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=$HOME/.zsh_history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
unsetopt BEEP

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/piotr/.zshrc'

### Activate vi / vim mode:
bindkey -v

# Remove delay when entering normal mode (vi)
KEYTIMEOUT=5

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Start with beam shape cursor on zsh startup and after every command.
zle-line-init() { zle-keymap-select 'beam'}

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

# zinit plugins that I added
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-completions
zinit light leophys/zsh-plugin-fzf-finder
zinit light Aloxaf/fzf-tab
zinit light Nyquase/vi-mode
zinit light zsh-users/zsh-history-substring-search

# search history using that cool substring search feature
bindkey -r "^[OA"
bindkey -r "^[OB"
bindkey -r "^P"
bindkey -r "^N"

bindkey "^[OA" history-substring-search-up
bindkey "^[OB" history-substring-search-down
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down

zinit light ael-code/zsh-colored-man-pages

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
