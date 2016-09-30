# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r $HOME/.dircolors && eval "$(dircolors -b $HOME/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
	export CLICOLOR=1
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
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


if [ -n "$TMUX" ]; then
	unset GVM_INIT
	export TERM='screen-256color'
else 
	export TERM='xterm-256color'
fi

#vim may be different places on different machines (use nvim if available)
export EDITOR=`which nvim 2>/dev/null || which vim 2> /dev/null || which vi`

#include bash_functions if it exists
if [ -f $HOME/.bash_functions ]; then
	. $HOME/.bash_functions
fi

#invoke bash_local if it exists
if [ -f $HOME/.bash_local ]; then
	. $HOME/.bash_local
fi

[[ -s $HOME/.nvm/nvm.sh ]] && source $HOME/.nvm/nvm.sh ${IS_SLOW_DISK:+--no-use}

#Invoke desk environment
[[ ! -z "$DESK_ENV" ]] && source "$DESK_ENV"

#Add /usr/local/bin to PATH
[[ -d /usr/local/bin ]] && PATH="$PATH:/usr/local/bin"

#Add ~/bin and ~/bin_local to PATH
if [[ "$PATH" != *$HOME/bin* ]]; then
	PATH="$PATH:$HOME/bin"
fi

if [[ "$PATH" != *$HOME/bin_local* ]]; then
	[[ -d $HOME/bin_local ]] && PATH="$PATH:$HOME/bin_local"
fi


#Add Git completion to bash
[[ -s $HOME/bin/git-completion.bash ]] && source $HOME/bin/git-completion.bash

#Setup Go if installed
[[ -d /usr/local/go/bin ]] && PATH="$PATH:/usr/local/go/bin"
if [[ -d $HOME/code/go ]]; then
	[[ -d $HOME/code/go/bin ]] && PATH="$PATH:$HOME/code/go/bin"
	#Add local go path if not there already and handle empty GOPATH if needed
	[[ $GOPATH == *"$HOME/code/go"* ]] || GOPATH="${GOPATH+$GOPATH:}$HOME/code/go"
fi

#phantonjs bin path
[[ -d /opt/phantomjs/bin ]] && PATH="$PATH:/opt/phantomjs/bin"

#Sensible bash
[[ -f $HOME/dotfiles/external/bash-sensible/sensible.bash ]] && source $HOME/dotfiles/external/bash-sensible/sensible.bash

#Init Z
[[ -f $HOME/dotfiles/external/z/z.sh ]] && source $HOME/dotfiles/external/z/z.sh

#Rustup
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

#Re-enable > clobber
set +o noclobber

#nice less options
export PAGER=less
# -i = ignore case
# -R = Raw control chars (make color work)
# -S = Chop long line
# -x 4 = tabs = 4 spaces
# -F = don't do anything if less than one screen of text
# -X don't init term at begin and exit
export LESS="-iRMSx4 -FX"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ -d /usr/local/bin ]] && PATH="/usr/local/bin:$PATH"
