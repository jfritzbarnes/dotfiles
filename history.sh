hgrep (){ find ~/.dir_bash_history/ -type f|xargs grep -h $*;}


# Usage: mycd 
# Replacement for builtin 'cd', which keeps a separate bash-history
# for every directory.
shopt -s histappend
alias cd="mycd"
export HISTFILE="$HOME/.dir_bash_history$PWD/bash_history.txt"
export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE='cd *:history*'
PROMPT_COMMAND='history -a'

function mycd()
{
  history -a # write current history file 
  builtin cd "$@" # do actual c d 
  local HISTDIR="$HOME/.dir_bash_history$PWD" # use& nbsp;nested folders for history 
  if [ ! -d "$HISTDIR" ]; then # create folder if neede d 
    mkdir -p "$HISTDIR"
  fi
  export HISTFILE="$HISTDIR/bash_history.txt" # set& nbsp;new history file 
  history -c # clear memory 
  history -r #read from current histfile 
}
