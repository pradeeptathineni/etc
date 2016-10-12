### SETUP: ###

# Color Definitions: #
RED="\033[0;31m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
CYAN="\033[0;96m"
BLUE="\033[0;34m"
WHITE="\033[0;37m"
RESET="\033[0m"
LIGHTRED="\033[0;91m"
OCHRE="\033[38;5;95m"
LIGHTGREEN="\033[0;92m"
LIGHTMAGENTA="\033[0;95m"

# Bash Shortcuts Help: #
read -r -d '' SCUTS << EOM
________________________________________________________________________________

Bash shortcuts.
________________________________________________________________________________

Usage:  Within Bash

[Command Editing Shortcuts]

    Ctrl + a        go to the start of the command line
    Ctrl + e        go to the end of the command line
    Ctrl + k        delete from cursor to the end of the command line
    Ctrl + u        delete from cursor to the start of the command line
    Ctrl + w        delete from cursor to start of word (i.e. delete backwards one word)
    Ctrl + y        paste word or text that was cut using one of the deletion shortcuts (such as the one above) after the cursor
    Ctrl + xx       move between start of command line and current cursor position (and back again)
    Alt + b         move backward one word (or go to start of word the cursor is currently on)
    Alt + f         move forward one word (or go to end of word the cursor is currently on)
    Alt + d         delete to end of word starting at cursor (whole word if cursor is at the beginning of word)
    Alt + c         capitalize to end of word starting at cursor (whole word if cursor is at the beginning of word)
    Alt + u         make uppercase from cursor to end of word
    Alt + l         make lowercase from cursor to end of word
    Alt + t         swap current word with previous
    Ctrl + f        move forward one character
    Ctrl + b        move backward one character
    Ctrl + d        delete character under the cursor
    Ctrl + h        delete character before the cursor
    Ctrl + t        swap character under cursor with the previous one

[Command Recall Shortcuts]

    Ctrl + r        search the history backwards
    Ctrl + g        escape from history searching mode
    Ctrl + p        previous command in history (i.e. walk back through the command history)
    Ctrl + n        next command in history (i.e. walk forward through the command history)
    Alt + .         use the last word of the previous command

[Command Control Shortcuts]

    Ctrl + l        clear the screen
    Ctrl + s        stops the output to the screen (for long running verbose command)
    Ctrl + q        allow output to the screen (if previously stopped using command above)
    Ctrl + c        terminate the command
    Ctrl + z        suspend/stop the command
________________________________________________________________________________
EOM
alias scuts='echo "$SCUTS"'

#------------------------------------------------------------------------------#

### ADDED BY DEEP: ###

# Functions: #
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_branch_color() {
    if [[ $(git diff 2> /dev/null | wc -c) == "0" ]]; then
        echo -e "${LIGHTGREEN}"
    else
        echo -e "${LIGHTRED}"
    fi
}
parse_hostname() {
    case $HOSTNAME in
        ("ptathineni-gui")  echo 'figlet "IN DEV ENV"';;
        (*)                 echo 'ssh ptathineni@192.168.77.77';;
    esac
}
pull_origin_master() { # todo
    REPOS=("INFRASTRUCTURE" "SHP" "FEED" "PATIENTAPP" "MAILER")
    for repo in "${REPOS[@]}"; do
        echo -e "${CYAN}//PULLING ${repo}//${RESET}"
    done
}


# File System Navigation: #
alias ..='cd ..'
alias ~='cd ~'
alias cdetc='cd ~/etc'
alias cdsrc='cd /src'
alias cdusr='cd /usr'
alias cdinf='cd ~/infrastructure'
alias cdfeed='cd /src/feed'
alias cdshp='cd /src/shp'
alias cdfx='cd /src/feed/externals'
alias cdsx='cd /src/shp/externals'
alias cdftest='cd /src/feed/externals/test-dataset'
alias cdpappy='cd /src/PatientApp'
alias cdbillpay='cd /src/billpay'
alias cdmailr='cd /src/mailer'

# File System Lookup: #
alias ls='ls --color=auto || ls -G'                     # generically show files, auto-color
alias ls.='ls -d --color=auto .* || ls -dG .*'          # show hidden files, auto-color
alias lsl='ls -la --color=auto || ls -laG'              # show files in long-listing format, auto-color

# Confirmation Required for File System Changes: #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Network and Server: #
alias ports='netstat -tulanp'                           # display all TCP/UDP ports on the server
alias header='curl -I'                                  # get web server headers
alias devbox=$(parse_hostname)                          # allows ssh into guest dev box from host machine

# Ping: #
alias ping='ping -c 3'                                  # ping server, stop after 3 packets sent and received
alias pingf='sudo ping -f -c 100 -D'                    # force ping server as root, stop after 100 packets sent and received

# CPU: #
alias meminfo='free -m -l -t'                           # get memory info
alias psmem='ps auxf | sort -nr -k 4'                   # get top processes eating memory
alias psmem10='ps auxf | sort -nr -k 4 | head -10'      # get top 10 process eating memory
alias pscpu='ps auxf | sort -nr -k 3'                   # get top processes eating cpu
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'      # get top 1- processes eating cpu
alias cpuinfo='lscpu'                                   # get server cpu info

# Git: #
alias gadd='git add'
alias gcam='git commit -am'
alias gcm='git commit -m'
alias gc='git commit'
alias gpuo='git push -u origin'
alias gpl='git pull'
alias gps='git pull && git push'
alias gco='git checkout'
alias gcoc='git checkout client-stable'
alias gcom='git checkout master'
alias gst='git status'
alias glg='git lg'
alias glog='git log'
alias glogo='git log --oneline'
alias gsh='git show'
alias gb='git branch'
alias gd='git diff'
alias gdm='git diff master'
alias gdom='git diff origin/master'
alias gmc='git merge origin/client-stable'
alias gmm='git merge origin/master'
alias grehard='git reset --hard'
alias gpm='git checkout master && git pull'
alias gsi='git submodule init'
alias gsu='git submodule update'
alias allorigin='echo -e ${CYAN}//PULLING INF//${RESET} && cdinf && gpm && echo -e ${CYAN}//PULLING FEED//${RESET} && cdfeed && gpm && echo -e ${CYAN}//PULLING SHP//${RESET} && cdshp && gpm && echo -e ${CYAN}//PULLING PATIENTAPP//${RESET} && cdpappy && gpm && echo -e ${CYAN}//PULLING MAILER//${RESET} && cdmailr && gpm && cdshp'

# Extras: #
alias h='history'
alias j='jobs -l'
alias bc='bc -l'                                        # calculator with math lib support
alias srcbash='source ~/.bashrc'                        # re-sources shell environment to ~/.bashrc; new changes made to ~/.bashrc will take effect without needing to open a new terminal

#------------------------------------------------------------------------------#

### ADDED BY PATIENTCO: ###

export TMP="/tmp/"

alias phpunitm='phpunit -d memory_limit=-1'
alias puf='phpunitm --filter'
alias phpm='php -d memory_limit=-1'
alias restartweb='sudo /etc/init.d/apache2 restart'
alias freq='sort | uniq -c | sort -nr' # useful line frequency analyzer
alias apg32='apg -M CLN -m 32 -x 32'
alias view='vim -R'

if id fhadmin >/dev/null 2>&1
then
    CLOUD='[Firehost]'
    PREFIX='\[\033[1;41m\] PRODUCTION \[\033[0m\]'
else
    CLOUD=''
    PREFIX=''
fi
export PS1="\n\e[41m[\T]\e[0m ${PREFIX}${debian_chroot:+($debian_chroot)}\u@\h${CLOUD}:${LIGHTMAGENTA}\w${RESET}\$(parse_branch_color)\$(parse_git_branch)${RESET}\n  $ "

# Mysql:
function show {
    mysqllocal -e "show $*"
}
function desc {
    mysqllocal -e "desc $*"
}
alias mysqldumplocal='mysqldump -u localdev --pass=localdev localdev'
alias mysqllocal='mysql -u localdev --pass=localdev localdev'
alias mysql_write='mysql --defaults-file=~/.mysql_credentials.rw'


# Strip color codes (useful after an command that always generates color codes, but you want to pipe -- e.g. phpunit)
alias stripcolor="sed 's/\\x1b\\[[0-9,;]*[mK]//g'"


#The following will be blank on all server (non-devbox) nodes:#
# <%=devbox_specific_bashrc%>



# nsgrep -- general purpose search utility:
[[ -z "$INCLUDEEXPERIMANTAL" ]] && alias nsgrep='find . -name \*~ -prune -o -name \.git -prune -o -name cache -prune -o -type f -print0 | xargs -0r grep -HnI --color=always' # there is a new version in the experimental section below
    # This started out as 'no-symlink' grep, but has evolved into alot more...
    #   This uses find for recursion instead of the one built into grep, which doesn't follow symlinks
    #
    #   The -print0 option on find uses NULL terminators instead of newlines to sparate results
    #   The -0r option to xargs parses stdin in a similar manner
    #   This approach is resilient to filenames with spaces and other weird characters
    #
    #   --color=always makes grep output color


## Set go root
export GOPATH=/src/go
export PATH=$PATH:/src/go/bin




# EXPERIMENTAL SECTION:
if [[ -n "$INCLUDEEXPERIMANTAL" ]]; then
    function nsgrep {
        # This started out as 'no-symlink' grep, but has evolved into alot more...
        HELPMODE=0
        if [[ "$1" = "--help" || "$1" = "-h" ]]; then
            shift
            if [[ "$#" = 0 ]]; then
                cat <<HELP
Best learned through examples:
    nsgrep --help
    nsgrep -h
        show help and exit
    nsgrep functionName
        search for regex 'functionName'
    nsgrep --help functionName
        show expanded bash command that would search for function name
    nsgrep migrations functionName
    search for regex 'functionName' in the directory 'migrations'
    nsgrep . functionName
        search for regex 'functionName' in the current directory (same as default)
    nsgrep . -i functionName
        case insensitive search for regex 'functionName' in the current directory (same as default)

UNDOCUMENTED FEATURE (read code for more info): reads .nsignore (in current directory) an runtine to get ignore patterns
HELP
                return
            fi
            HELPMODE=1
        fi
        TEMP="$IFS" # save
        IFS=$'\n'
        if [[ -f .nsignore ]]; then
            NSIGNORE=( $(cat .nsignore | sed -e 's/#.*$//' -e 's/^ *//g' -e 's/ *$//g' -e '/^$/d') )
        else
            NSIGNORE=(
            # You can dump the following into your .nsignore file as a starting point (make sure to remove the single quotes):
                'dir  -wholename ./.git'       # git
                'file -name      \*~'          # Any gedit temp files
                'file -name      .\*.sw?'      # Any vim temp files
                'dir  -name      cache'        # smarty cache directories
                # other suggestions:
                #'file -name      \*.sql'       # Any SQL files
                #'file -wholename ./tags'       # VIM tag file
                #'file -name      jquery\*.js'  # JQuery code
                #'dir  -wholename ./cachegrind' # cachegrind files
                #'dir  -wholename ./xdebug'     # cachegrind files
            )
        fi
        IFS="$TEMP" # restore
        FILES=()
        DIRS=()
        for i in "${NSIGNORE[@]}"; do
            SPLIT=( "${i%% *}" "$(echo "$i" | sed 's/^[^ ]* \+//')" )
            case "${SPLIT[0]}" in
                file)
                    FILES=( "${FILES[@]}" "${SPLIT[1]}" )
                    ;;
                dir)
                    DIRS=( "${DIRS[@]}" "${SPLIT[1]}" )
                    ;;
                *)
                    echo "UNRECOGNIZED: $(printf %q "$i")"; return
                    ;;
            esac
        done
        ARGS="\\( $(printf ' -type d %s -prune -o' "${DIRS[@]}") -true \\) -type f \\! \\( $(printf ' %s -o' "${FILES[@]}") -false \\)"
        if [[ "$#" = 1 ]]; then
            ROOTDIR='.'
        else
            ROOTDIR="$1"
            shift
        fi
        if [ -t 1 ]; then # if the output is going to a terminal
            COLOR=always
        else # otherwise, the output may be going to something else, so don't color
            COLOR=never
        fi
        COMMAND="find $(printf %q "$ROOTDIR") $ARGS -print0 | xargs -0r grep -HnI --color=$COLOR $(printf %q\  "$@")"
        if [[ "$HELPMODE" = "1" ]]; then
            echo "$COMMAND"
        else
            eval "$COMMAND"
        fi
    }

    # Badass git logging:
        alias gl_basic="git lg HEAD \`(git branch | sed -e '/(no branch)/ d' -e 's/^.* //' && git config --list | sed -n 's_^branch\\.[a-zA-Z-]\\+\\.merge=refs/heads/\\([a-zA-Z-]\\+\\)\$_origin/\\1_p') | tr '\\n' ' '\` --"
        alias gl='gl_basic | awk "
            {local = \" \"; remote = \" \"; preline=\"\"}
            /refs\/heads\// {local = \"@\"}
            /refs\/remotes\/origin\// {remote = \"~\"}
            (local == \"@\") && (remote == \" \") {preline = \"\\033[4m\"}
            /`git rev-parse HEAD | cut -c-7`/ {preline = preline \"\033[7m\"}
            {
                gsub(/\\033\\[m/, \"&\" preline)
                print preline local remote \" \" \$0
            }
        " | less -FRSX'

    # Puppet filebucket:
        alias filebucket_from_md5='sudo puppet filebucket get -l --bucket /var/lib/puppet/clientbucket'
fi







# GRAVEYARD -- ideas that I tried, but never worked out.  Left here in case I want to pick them up later:
    # BADASSIER LOGGING:
        # alias gl3='gl_basic | awk "
        #     {local = \" \"; remote = \" \"; preline=\"\"}
        #     /refs\/heads\// {local = \"@\"}
        #     /refs\/remotes\/origin\// {remote = \"~\"}
        #     (local == \"@\") && (remote == \" \") {preline = \"\\033[4m\"}
        #     {
        #         gsub(/\\033\\[m/, \"&\" preline)
        #         print preline local remote \" \" \$0
        #     }
        # " | highlight `cat .git/HEAD | sed "s/^.* //g"` | less -FRSX'
        #alias gl3='gl_basic | sed -e "s/^/  /" -e "\\_refs/remotes/origin/_ s/^./~/" -e "s/^/ /" -e "\\_refs/heads/_ s/^./@/" -e "s_refs/heads/master_\\033[7m\0\<--_"'
    # DEPRECATED AS OF 2013-12-20 (by Jonathan Loesch)
        # alias sshh='ssh -p 5100'
        # alias cdservers='cd /src/servers'
