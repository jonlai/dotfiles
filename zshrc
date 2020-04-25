# general settings
stty -ixon
export PAGER='less'
export LESS='-R'
export EDITOR='vim'
export KEYTIMEOUT=1
setopt vi

# zinit setup
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# plugins
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit light zsh-users/zsh-syntax-highlighting
zinit ice from'gh-r' as'program' mv'ripgrep* -> ripgrep' pick'ripgrep/rg'
zinit light BurntSushi/ripgrep

# fzf
if [[ ! -f $HOME/.fzf/bin/fzf ]]; then
  command git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  command "$HOME/.fzf/install" --bin
fi
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --glob "!.git/*"'
source "$HOME/.fzf/shell/completion.zsh"
source "$HOME/.fzf/shell/key-bindings.zsh"

# path
[[ ":$PATH:" != *":$HOME/.fzf/bin:"* ]] && export PATH="$PATH:$HOME/.fzf/bin"
[[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]] && export PATH="$PATH:$HOME/.cargo/bin"

# aliases
alias ll='ls -lh'
alias lla='ls -lAh'
alias cdr='cd $(git rev-parse --show-toplevel 2>/dev/null)'

# history
[[ -z "$HISTFILE" ]] && export HISTFILE=$HOME/.zsh_history
export HISTSIZE=25000
export SAVEHIST=$HISTSIZE
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# key-bindings
bindkey '^f' forward-word
bindkey '^b' backward-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^h' backward-delete-char

if [[ "${terminfo[kcuu1]}" != '' ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
if [[ "${terminfo[kcud1]}" != '' ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# prompt
ind='❯❯'
rtc="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})"
PROMPT=' %{$fg_bold[cyan]%}%c $(git_prompt_info)${rtc}${ind}%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}✗ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) "

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    ind="${${KEYMAP/vicmd/𝙑𝙄}/(main|viins)/❯❯}"
    zle reset-prompt
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  function zle-keymap-select() {
    ind="${${KEYMAP/vicmd/𝙑𝙄}/(main|viins)/❯❯}"
    zle reset-prompt
  }
  zle -N zle-line-init
  zle -N zle-line-finish
  zle -N zle-keymap-select
fi

autoload -U compinit && compinit
