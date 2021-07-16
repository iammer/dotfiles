# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export DOTFILES=$HOME/dotfiles

export TZ=GMT

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

HISTIGNORE="$HISTIGNORE:stophist"

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
	PS1="\[\033[38;5;10m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;12m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"
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

#Add /usr/local/bin to PATH
[[ -d /usr/local/bin ]] && PATH="/usr/local/bin:$PATH"

#Add snap path to PATH
[[ -d /snap/bin ]] && PATH="/snap/bin:$PATH"

#Add ~/bin, .local/bin, and ~/bin_local to PATH
for path in bin bin_local .local/bin; do
	if [[ -d "$HOME/$path" ]] && [[ "$PATH" != *$HOME/$path* ]]; then
		PATH="$PATH:$HOME/$path"
	fi
done


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
	export TERM='screen-256color'
fi

#Add Git completion to bash
[[ -s $HOME/bin/git-completion.bash ]] && source $HOME/bin/git-completion.bash

#phantonjs bin path
[[ -d /opt/phantomjs/bin ]] && PATH="$PATH:/opt/phantomjs/bin"

#Sensible bash
[[ -f $DOTFILES/external/bash-sensible/sensible.bash ]] && source $DOTFILES/external/bash-sensible/sensible.bash

### Undo sensible things I don't like
#Re-enable > clobber
set +o noclobber

#Case-sensitive glob and append cd automatically
shopt -u nocaseglob autocd 2> /dev/null


#Invoke desk environment
[[ ! -z "$DESK_ENV" ]] && source "$DESK_ENV"
[[ -f $DOTFILES/external/desk/shell_plugins/bash/desk ]] && source $DOTFILES/external/desk/shell_plugins/bash/desk

#Init Z
[[ -f $DOTFILES/external/z/z.sh ]] && source $DOTFILES/external/z/z.sh

#nice less options
export PAGER=less
# -i = ignore case
# -R = Raw control chars (make color work)
# -S = Chop long line
# -x 4 = tabs = 4 spaces
# -F = don't do anything if less than one screen of text
# -X don't init term at begin and exit
export LESS="-iRMSx4 -FX"

#vim may be different places on different machines (use nvim if available)
export EDITOR=$(which nvim 2>/dev/null || which vim 2> /dev/null || which vi)

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/dotfiles/bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f $DOTFILES/bash_aliases ]; then
    source $DOTFILES/bash_aliases
fi

#include bash_functions if it exists
if [ -f $DOTFILES/bash_functions ]; then
	source $DOTFILES/bash_functions
fi

#invoke bash_local if it exists
if [ -f $HOME/.bash_local ]; then
	source $HOME/.bash_local
fi

#invoke .local/bashrc if it exists
if [ -f $HOME/.local/bashrc ]; then
	source $HOME/.local/bashrc
fi

if [[ "$MANPATH" != *$HOME/man_local* ]]; then
	[[ -d $HOME/man_local ]] && MANPATH="$MANPATH:$HOME/man_local"
fi

#invoke platform specific files if they exist
PLATFORM=$(uname | tr '[:upper:]' '[:lower:]')
if [ -f $DOTFILES/bash_$PLATFORM ]; then
	source $DOTFILES/bash_$PLATFORM
fi

#Setup deno if installed
if [[ -d $HOME/.deno ]]; then
	export DENO_INSTALL="$HOME/.deno"
	export PATH="$DENO_INSTALL/bin:$PATH"
fi

#Setup nvm if installed, lazy-load if IS_SLOW_DISK (set in .bash_local)
if [[ -s $HOME/.nvm/nvm.sh ]]; then
	NVM_SCRIPT=$HOME/.nvm/nvm.sh
	if [[ $IS_SLOW_DISK ]]; then
		source $NVM_SCRIPT --no-use
		NODE_CMDS="node npm"
		for NODE_CMD in $NODE_CMDS; do
			alias $NODE_CMD="unalias $NODE_CMDS && nvm use default && $NODE_CMD"
		done
		unset NODE_CMDS NODE_CMD
	else
		[[ -z $DESK_NAME ]] && source $NVM_SCRIPT
	fi
else #Use node installed in /opt/node if exists
	if [[ -d /opt/node/bin ]]; then
		PATH="$PATH:/opt/node/bin"
	fi
fi

#Setup Go if installed
for path in /usr/local/go/bin /opt/go/bin $HOME/code/go/bin; do
	[[ -d $path ]] && PATH="$PATH:$path"
done
if [[ -d $HOME/code/go ]]; then
	#Add local go path if not there already and handle empty GOPATH if needed
	[[ $GOPATH == *"$HOME/code/go"* ]] || export GOPATH="${GOPATH+$GOPATH:}$HOME/code/go"
	PATH="$PATH:$GOPATH/bin"
fi

#Rustup
if [[ -f $HOME/.cargo/env ]]; then
	source $HOME/.cargo/env
	[[ $LD_LIBRARY_PATH == *"/usr/local/lib"* ]] || export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#Cabal (ghc package manager)
if [[ -d $HOME/.cabal/bin ]]; then
	PATH="$PATH:$HOME/.cabal/bin"
fi

#Setup gcloud
GCLOUD_PATH=''
for path in /usr $HOME $HOME/sdk /opt; do
	if [[ -z "$GCLOUD_PATH" && -d "$path/google-cloud-sdk" ]]; then
		GCLOUD_PATH="$path/google-cloud-sdk"
	fi
done

for inc in completion.bash.inc path.bash.inc; do
	[[ -f "$GCLOUD_PATH/$inc" ]] && source "$GCLOUD_PATH/$inc"
done

#Remove parallel nag
[[ -f "$HOME/.parallel/will-cite" ]] || (mkdir $HOME/.parallel 2> /dev/null ; touch $HOME/.parallel/will-cite)

#Nim
[[ -d "/opt/nim/bin" ]] && PATH="$PATH:/opt/nim/bin"
[[ -d "$HOME/.nimble/bin" ]] && PATH="$PATH:$HOME/.nimble/bin"

#Julia
[[ -d "/opt/julia/bin" ]] && PATH="$PATH:/opt/julia/bin"

#Remove any duplicate entries from PATH
if [ -n "$PATH" ]; then
	old_PATH=$PATH:; PATH=
	while [ -n "$old_PATH" ]; do
		x=${old_PATH%%:*}   # the first remaining entry
		case $PATH: in
			*:"$x":*) ;;   # already there
			*) PATH=$PATH:$x;;   # not there yet
		esac
		old_PATH=${old_PATH#*:}
	done
	PATH=${PATH#:}
	unset old_PATH x
fi
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#R
if which R > /dev/null; then
	[[ -d $HOME/.local/lib/R ]] || mkdir -p $HOME/.local/lib/R
	export R_LIBS_USER=$HOME/.local/lib/R
fi

#Pico
if [[ -d $HOME/code/pico/pico-sdk ]]; then
	export PICO_SDK_PATH=$HOME/code/pico/pico-sdk
fi

#rbenv
if [[ -d $HOME/.rbenv/bin ]]; then
	PATH="$HOME/.rbenv/bin:$PATH"
	if which rbenv > /dev/null; then
		eval "$(rbenv init -)"
	fi
fi
