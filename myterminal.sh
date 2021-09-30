#defining different colors
export COLOR_NC='\e[0m' # No Color
export COLOR_BLACK='\e[0;30m'
export COLOR_GRAY='\e[1;30m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export COLOR_WHITE='\e[1;37m'

#KALI TYPE PS1
if [ $USER == "root" ];
then
    echo "you are root be cautious!!!"
	PS1="\[\e]0;\u@\h: \w\a\]\[\033[;94m\]┌──(\[\033[1;31m\]\u@\h\[\033[;94m\])-[\[\033[0;1m\]\w\[\033[;94m\]]\n\[\033[;94m\]└─\[\033[1;31m\]#\[\033[0m\] "
else
	PS1="\[\e]0;\u@\h: \w\a\]\[\033[;32m\]┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)\[\033[;32m\])}(\[\033[1;34m\]\u@\h\[\033[;32m\])\$(__git_ps1)-[\[\033[0;1m\]\w\[\033[;32m\]]\n\[\033[;32m\]└─\[\033[1;34m\]\$\[\033[0m\] "
fi
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM=auto

#output filter to be used if a app create a lot of noise in terminal like gedit
of() { 
    if [ -n "$*" ]; then   
        # write the real command to history without the prefix "of" 
        history -s "$*"

        # catch the command output
        errorMsg=$( $* 2>&1 )

        # check if the command output contains not a GTK-Warning
        echo "$errorMsg"2>>~/.errlog
    fi
}

#Color your prompt
export TERM=xterm-color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# git push 
push() {
    local msg="$1"
    git add .
    git commit -m "$msg"
    git push origin
}

#To Use this remove '#': write the function "of" before every command if the user presses F12
#bind '"\e[24~": "\e[1~ of \e[4~\n"'

#a func to make a dir and get in
mkdirin() {
    mkdir "$1"
    cd "$1"
}

#add .gitignore anywhere
function add-gitignore() {
    cp ~/.gitignore .gitignore
}

#auto install any program

#aliases
#alias gedit='of gedit' #of = output filter
alias rnm='mv' #for rename
alias cls='clear' #clear screen
alias upgrade='sudo apt upgrade' 
alias update='sudo apt update'
alias UP='update && upgrade' #shortening the name
alias git-init='git init && add-gitignore' #init the dir as well as add gitignore
alias la='ls -a'
alias clear='printf "\033c"'

#git-setup
function setup-git() {
    var=`git --version`
    echo "$var"
    if [[ "$var" == "git version"* ]];
    then
        printf "username: "
        read user
        printf "email: "
        read email
        git config --global user.name "$user"
        git config --global user.email "$email"
        echo -e "$COLOR_GREEN Open: https://github.com/settings/ssh/new $COLOR_NC"
        echo -e "$COLOR_CYAN Generating ssh-key please only press enter-key for every querry $COLOR_NC"
        ssh-keygen
        echo -e "$COLOR_RED Copy this ssh key $COLOR_NC"
        cat ~/.ssh/id_rsa.pub
        echo -e "$COLOR_RED Paste these to the key area asked in the above link $COLOR_NC"
    else
        echo "git not avilable"
        printf "install git now? (Y/n): "
        var="y"
        read var
        if [ "$var" == "y" ] || [ "$var" == "Y" ];
        then
            sudo apt install git
        else
            echo "Quiting..."
        fi
    fi
}