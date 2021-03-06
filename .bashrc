# .bashrc

# return if not running interactively
[ -z "$PS1" ] && return
. /etc/profile > /dev/null

# behave like vi
set -o vi

# history
PROMPT_COMMAND='history -a; history -n'
HISTCONTROL=ignoredups
HISTIGNORE='ls:bg:fg:history'
HISTSIZE=1000
shopt -s histappend
shopt -s cmdhist

# etc
shopt -s checkwinsize

export GREP_OPTIONS="--color=auto"
export GREP_COLOR="1;32"
export EDITOR="vim"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:usr/X11/bin"
export COPYFILE_DISABLE=true

# Load Homebrew's bash-completion helpers
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
    GIT_PROMPT_THEME=Default
    source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi

# Default prompt
#PS1='\e[0;31m]\w \$ '
#PS1="\e[0;31m[\w]\$"
#export PS1="\e[0;31m[\w]\$ \e[m"

# Use a git-aware prompt if one is available
if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
	PS1='\e[0;31m[\w] \e[m $(__git_ps1 "(%s) ")\$ '
fi

# ls colors
# (via http://github.com/inky/dotfiles/blob/master/home/.bashrc)
uname=$(uname)
if [ "$TERM" != "dumb" ]; then
    case "$uname" in
    Darwin|FreeBSD)
        export CLICOLOR=1
        export LSCOLORS="ExFxCxDxBxegedabagacad"  # legible colours
        ;;
    *)
        if [ -n "`which dircolors`" ]; then
            eval "`dircolors -b`" 2>/dev/null
            alias ls='ls --color=auto' 2>/dev/null
        fi
        ;;
    esac
fi

# Include alias definitions
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Include environment-specific odds-n-ends
if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
