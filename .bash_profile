export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
PS1="\[\033[38;5;227m\]\A \[\033[38;5;14m\]\w \[\033[38;5;32m\$(tput bold)\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)): \[$(tput sgr0)\]"
[ `uname -s` != "Darwin" ] && return

function tab () {
    local cdto="$PWD"
    local args="$@"

    if [ -d "$1" ]; then
        cdto=`cd "$1"; pwd`
        args="${@:2}"
    fi

    osascript &>/dev/null <<EOF
        tell application "System Events"
            tell process "Terminal" to keystroke "t" using command down
        end tell
        tell application "Terminal"
            activate
            do script with command "cd \"$cdto\"; $args" in selected tab of the front window
        end tell
EOF
}


pyclean () {
        find . -type f -name "*.py[co]" -delete
        find . -type d -name "__pycache__" -delete
}
export GOPATH=$HOME/work
export GOBIN=$HOME/work/bin
export PATH="$GOBIN:$PATH"
# added by Anaconda2 4.4.0 installer
# export PATH="/Users/Cameron/anaconda2/bin:$PATH"

# added by Anaconda3 5.0.1 installer
export PATH="/Users/Cameron/anaconda2/bin:$PATH"

export DBASH="sh -c \"stty rows 50 && stty cols 150 && bash\""
goinside(){
    docker exec -it $1 bash -c "stty cols $COLUMNS rows $LINES && bash";
}
export -f goinside

#git autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export MONGO_PW=<SECRET>
connect_to_mongo(){
    mongo <ADDRESS>:<PORT>/admin --username admin --password <SECRET>;
}
export -f connect_to_mongo

git_remove_merged(){
    git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d
}
export -f git_remove_merged
