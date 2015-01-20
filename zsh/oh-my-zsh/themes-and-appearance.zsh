autoload -U colors && colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

if [[ "$OSTYPE" == darwin* ]]; then
  ls -G . &>/dev/null && alias ls='ls -G'
  [[ -n "$LS_COLORS" || -f "$HOME/.dircolors" ]] && \
    gls --color -d . &>/dev/null && alias ls='gls --color=tty'
else
  [[ -z "$LS_COLORS" ]] && \
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
  ls --color -d . &>/dev/null && \
    alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' ; }
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

setopt auto_cd
setopt multios
setopt prompt_subst

# theme defaults
PS1="%n@%m:%~%# "
ZSH_THEME_GIT_PROMPT_PREFIX="git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
