# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

function add_to_path {
	if [[ -d "$1" && "$PATH" != "*$1*" ]]; then
		if [[ "$2" == "start" ]]; then
			PATH="$1:$PATH"
		else
			PATH="$PATH:$1"
		fi
	fi
}

function load {
	if [[ -s "$1" ]]; then
		source "$1"
	fi
}


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

load $HOME/bin/git-completion.bash

#Sensible bash
load $DOTFILES/external/bash-sensible/sensible.bash

### Undo sensible things I don't like
#Re-enable > clobber
set +o noclobber

#Case-sensitive glob and append cd automatically
shopt -u nocaseglob autocd 2> /dev/null

#Invoke desk environment
load "$DESK_ENV"
load $DOTFILES/external/desk/shell_plugins/bash/desk

#Init Z
load $DOTFILES/external/z/z.sh

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

load $DOTFILES/bash_aliases
load $DOTFILES/bash_functions
load $HOME/.bash_local
load $HOME/.local/bashrc

if [[ "$MANPATH" != *$HOME/man_local* ]]; then
	[[ -d $HOME/man_local ]] && MANPATH="$MANPATH:$HOME/man_local"
fi

#invoke platform specific files if they exist
load $DOTFILES/bash_$(uname | tr '[:upper:]' '[:lower:]')

#Setup deno if installed
if [[ -d $HOME/.deno ]]; then
	export DENO_INSTALL="$HOME/.deno"
	add_to_path "$DENO_INSTALL/bin"
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
		add_to_path /opt/node/bin
	fi
fi

#Setup Go if installed
if [[ -d $HOME/code/go ]]; then
	#Add local go path if not there already and handle empty GOPATH if needed
	[[ $GOPATH == *"$HOME/code/go"* ]] || export GOPATH="${GOPATH+$GOPATH:}$HOME/code/go"
	add_to_path "$GOPATH/bin"
fi

#Rustup
if [[ -f $HOME/.cargo/env ]]; then
	source $HOME/.cargo/env
	[[ $LD_LIBRARY_PATH == *"/usr/local/lib"* ]] || export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
load "$HOME/.sdkman/bin/sdkmain-init.sh"

#Cabal (ghc package manager)
load $HOME/.cabal/bin

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

load "$NVM_DIR/bash_completion"

#R
if which R > /dev/null; then
	[[ -d $HOME/.local/lib/R ]] || mkdir -p $HOME/.local/lib/R
	export R_LIBS_USER=$HOME/.local/lib/R
fi

#Pico
if [[ -d $HOME/code/pico/pico-sdk ]]; then
	export PICO_SDK_PATH=$HOME/code/pico/pico-sdk
fi

#pyenv
if [[ -d $HOME/.pyenv/bin ]]; then
	add_to_path "$HOME/.pyenv/bin"
	export PYENV_ROOT="$HOME/.pyenv"
	if which pyenv > /dev/null; then
		eval "$(pyenv init --path)"
	fi
fi

#Poetry
load $HOME/.poetry/env

while read path_dir; do
	add_to_path $path_dir
done <<-END_PATHS
	/usr/local/bin start
	/snap/bin start
	$HOME/bin start
	$HOME/bin_local start
	$HOME/.local/bin start
	/opt/phantomjs/bin
	/opt/nim/bin
	$HOME/.nimble/bin
	/opt/julia/bin
	$HOME/.local/tfenv/bin
	$HOME/.local/tgenv/bin
	/opt/heroku/bin
	/usr/local/go/bin
	/opt/go/bin
	$HOME/code/go/bin
	$HOME/.yarn/bin
END_PATHS

#rbenv
if [[ -d $HOME/.rbenv/bin ]]; then
	add_to_path "$HOME/.rbenv/bin" start
	if which rbenv > /dev/null; then
		eval "$(rbenv init -)"
	fi
fi

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

unset -f add_to_path
unset -f load
