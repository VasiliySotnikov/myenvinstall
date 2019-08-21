# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples



# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
#shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignorespace:ignoredups

## reedit a history substitution line if it failed
shopt -s histreedit
## edit a recalled history line before executing
shopt -s histverify

_bash_history_sync() {
    builtin history -a         #1
    HISTFILESIZE=$HISTSIZE     #2
    #builtin history -c         #3
    #builtin history -r         #4
}

history() {                  #5
    _bash_history_sync
    builtin history "$@"
}

PROMPT_COMMAND="_bash_history_sync; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias gtr='git update && git tree'
git-push-FORCE-REMOTE() {
    [ "$1" != "" ] && git push --delete origin "$1" && git push --set-upstream origin "$1"
}
alias git-current-branch='git rev-parse --abbrev-ref HEAD'

# let less to pick up ANSI color from the pipe
alias less='less -R'

# quickly open with the default program
alias op='xdg-open > /dev/null 2>&1'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Link locally built libraries
export PATH="$HOME/local/bin":$PATH
export PATH="$HOME/local/usr/bin":$PATH
# pip bin
export PATH="$HOME/.local/bin":$PATH
export LD_LIBRARY_PATH="$HOME/local/lib":"$HOME/local/lib64":$LD_LIBRARY_PATH 
export LD_LIBRARY_PATH="$HOME/local/usr/lib":$LD_LIBRARY_PATH 
export LD_LIBRARY_PATH="$HOME/local/lib/x86_64-linux-gnu/":$LD_LIBRARY_PATH 

export NINJA_STATUS="%r running [%f/%t] elapsed: %e s || "


# ******************************************
# This is quick build commands for BH
# ******************************************
reconfigbh() {
    cd "$HOME/blackhat/$(pwd | sed "s/.*blackhat\/\([^\/]*\)\/*.*/\1/")"; 
    autoreconf -fi
    OPTIONS="$@"
    (cd build/; ../configure --prefix=$PWD --with-QDpath=$HOME/local/ --enable-public=no --enable-readline=no --enable-BHdebug=yes CXXFLAGS="$OPTIONS" && make -j && make install)
    cd - >/dev/null
}

maketest(){
    touch -c ../../my_programs/"$1".cpp && make ""$1".exe" $2 && (./"$1" 2>&1) | tee ""$1".log"
}
buildandmaketest(){
    (cd ../; make $2 && make install >/dev/null) && maketest "$1" $2
}


#******************************************
# This is to save ssh passphrase
#******************************************

SSH_ENV=$HOME/.ssh/environment

function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
}

svnpass(){
    if [ -f "${SSH_ENV}" ]; then
        . ${SSH_ENV} > /dev/null
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
    else
        start_agent;
    fi
}

# ******************************************


# set ls color scheme
eval "`dircolors -b $HOME/.dircolors/dircolors.ansi-dark`"

# set vim as default editor
export VISUAL=vim
export EDITOR="$VISUAL"

set -o vi

# set pkgconfig path for local packages
export PKG_CONFIG_PATH="$HOME/local/lib/pkgconfig/:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$HOME/local/lib/x86_64-linux-gnu/pkgconfig/:$PKG_CONFIG_PATH"
export PKG_CONFIG_PATH="$HOME/local/share/pkgconfig/:$PKG_CONFIG_PATH"

# disable annoying system beeps
xset b off &> /dev/null

# turn off history expension (replacing '!' by something)
set +H
