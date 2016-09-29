### SETUP: ###

# Color Definitions: #
RED="\033[0;31m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
OCHRE="\033[38;5;95m"
BLUE="\033[0;34m"
WHITE="\033[0;37m"
RESET="\033[0m"

#------------------------------------------------------------------------------#

### ADDED BY DEEP: ###

# Functions: #
up() {
    COUNTER=$1
    while [[ $COUNTER -gt 0 ]]
        do
            UP="${UP}../"
            COUNTER=$(( $COUNTER -1 ))
        done
    echo "cd $UP"
    cd $UP
    UP=''
}
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_branch_color() {
    if [[ $(git diff 2> ~/log.txt | wc -c) == "0" ]]; then
        echo -e "${GREEN}"
    else
        echo -e "${RED}"
    fi
}

# File System Navigation: #
alias ..='cd ..'
alias ~='cd ~'
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
#alias up='$(up)'

# File System Lookup: #
alias ls='ls --color=auto'          # generically show files, auto-color
alias ls.='ls -d .* --color=auto'   # show hidden files, auto-color
alias lsl='ls -la --color=auto'     # show files in long-listing format, auto-color

# Confirmation Required for File System Changes: #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Network: #
alias ports='netstat -tulanp'       # display all TCP/UDP ports on the server
alias header='curl -I'              # get web server headers 

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
alias allorigin='cdfeed cdshp cd'

# Extras: #
alias h='history'
alias j='jobs -l'
alias bc='bc -l'                    # calculator wuth math lib support

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
e7399278d259b4426eb790e1a839d58fe32fa308
export PS1="\n\e[41m[\T]\e[0m ${PREFIX}${debian_chroot:+($debian_chroot)}\u@\h${CLOUD}:\w\$(parse_branch_color)\$(parse_git_branch)\n${RESET}  \$ "

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
