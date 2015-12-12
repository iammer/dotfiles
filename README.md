###Dotfiles###
My dotfiles

####Installation####
1. Clone this repo into your home directory
1. Run install.sh
1. Old dotfiles will be in dotfiles\_old, you can delete this if you are sure you won't need them anymore.  Symlinks will be created from dotfiles to your home repo.
1. If a ~/bin directory exists it will be renamed to bin\_local (added to the path in bashrc)

####Usage####
Includes vim, tmux, and git configurations; bashrc, bash\_aliases, and bash\_functions; common utils in bin (included in PATH in bashrc)

#####Vim####
* Defaults to 4-character wide tabs unless editing javascript or html.
* Leader key is the default \\
* \\l toggles showing tabs and eol characters
* S-motion will replace text with contents of a register see :h ReplaceWithRegister
* ^p searches the file tree by name
* Uses a custom colorscheme (iammer) based on vividchalk
* Maps jk to ^[ / esc
* Defaults / searchs to very magic
* Y yanks from cursor to end of line
* , and . indent/dedent in visual mode
* \\ew edits a file in a new window
* \\es edits a file in a new horizonal split
* \\ev edits a file in a new vertical split
* \\et edits a file in a new tab
* \\em edits the current vimrc in a vertical split
* \\sm refreshes config from the current vimrc
* \\h turns off search highlighting
* \\n toggles NERDTree
* \\w toggles word wrapping
* \\p toggles paste mode
* \\m toggles numbering mode (absolute/relative)
* \\o Adds a line below (does not start insert mode)
* \\O Adds a line above (does not start insert mode)
* \\f Easy-motion find by letter forward
* \\F Eash-motion find by letter backward
* \\[ Easy-motion by word forward
* \\] Easy-motion by word backward (see :h easy-motion)

Plugins:
* ack.vim
* bufexplorer
* camelcasemotion
* ctrlp.vim
* ember.vim
* emmet-vim
* gist-vim
* nerdtree
* portkey
* ReplaceWithRegister
* rust.vim
* spin.vim
* vim-airline
* vim-coffee
* vim-colorschems
* vim-dispatch
* vim-easymotion
* vim-emblem
* vim-fugitive
* vim-jade
* vim-javascript
* vim-mustache-handlebars
* vim-pathogen
* vim-repeat
* vim-signify
* vim-surround
* webapi-vim
 
#####Tmux#####
* vi mode buffers
* right part of status line created from output of ~/bin/tmux-status. Shows time and system load
* Select current pane with hjkl instead of arrow keys
* Vertical split with | and \\
* ! goes to command prompt
* Panes can be resized with shift-hjkl for one step and ctrl-hjkl for five steps
* ctrl-u is a shortcut to ctrl-b ctrl-u
* R reloads config from tmux.conf
* Q splits the current pane into 4 "Quad"
* T splits the current pane into 3 "Tri"
* y/Y Toggle pane synchronization on (y) or off (Y)
* tmux will include ~/.tmux.local.conf if it exists
* Running tmSwapA from the command line will mark a pane for swapping
* Running tmSwapB \<char\> will bind the given char to swap the pane marked with tmSwapA with the current pane
* Running tmAvailKeys with list the unbound tmux keys

#####Bash#####
* up \<num\> will go to the *num*th parent of the current directory
* grailsTestOrder will list the last tests run in the current grails project in order

####Included External Tools####
* [Desk] (https://github.com/jamesob/desk)
* [Z] (https://github.com/rupa/z)


####install.sh####
Creates the needed symlinks.  Run once after cloning the repo

####refresh.sh####
Run to update dotfiles with most recent versions and to create any new symlinks
