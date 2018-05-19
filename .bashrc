export PS2="->"
export EDITOR=vim
export TERM=xterm-256color
export COLORTERM=xterm-256color
export CDPATH=.:~:~/git/go/src/github.com:~/git
export GOBIN=~/git/go/bin
export GOPATH=~/git/go
export GOROOT=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:~/bin:~/go/bin:~/git/go/bin
export PATH=$PATH:/usr/local/bin

export PATH=$PATH:/opt/cassandra/current/bin:/opt/elasticsearch/current/bin
export PATH=$PATH:/opt/hypertable/current/bin:/opt/redis/current/src
export PATH=$PATH:/opt/solr/current/bin
export PATH=$PATH:/opt/phoenix/current/bin
export PATH=$PATH:/usr/local/share/arm-eabi-4.6/bin
export PATH=$PATH:~/tools/android-ndk-r10e
export EDITOR=vim
alias rmpyc='find . -name "*.pyc" -exec rm -rf {} \;'
alias armcc='export ARCH="arm";export SUBARCH="arm";export CROSS_COMPILE="arm-eabi-"'



j8() {
    export CLASSPATH=/opt/java/8/jdk1.8.0_60/lib
    export JAVA_HOME=/opt/java/8/jdk1.8.0_60/
}

# VIRTUAL_ENV_PS1="${PS1%"\\$ "}\[\033[01;31m\]( VIRTUAL_ENV_NAME )\[\033[00m\]\$ "
# 
# if [ -n "$VIRTUAL_ENV_PS1" -a -n "$VIRTUAL_ENV_NAME" ]; then
#     PS1="${VIRTUAL_ENV_PS1//VIRTUAL_ENV_NAME/$VIRTUAL_ENV_NAME}"
# fi
# export PS1

export PATH=$PATH:/usr/lib/dart/bin
export PATH=$HOME/.pub-cache/bin:$PATH
export PATH=/home/dan/Android/Sdk/build-tools/23.0.1:$PATH
export PATH=/home/dan/Android/Sdk/platform-tools:$PATH
export PATH=/home/dan/Android/Sdk/tools:$PATH
export ANDROID_SDK_HOME=/home/dan/Android/Sdk
export ANDROID_HOME=/home/dan/Android/Sdk
#export PATH=/home/dan/anaconda2/bin:$PATH

alias ivm='vim'

# Everyone needs a little color in their lives
RED='\[\033[31m\]'
GREEN='\[\033[32m\]'
YELLOW='\[\033[33m\]'
BLUE='\[\033[34m\]'
PURPLE='\[\033[35m\]'
CYAN='\[\033[36m\]'
WHITE='\[\033[37m\]'
NIL='\[\033[00m\]'

# Hostname styles
FULL='\H'
SHORT='\h'

# System => color/hostname map:
# UC: username color
# LC: location/cwd color
# HD: hostname display (\h vs \H)
# Defaults:
UC=$GREEN
LC=$BLUE
HD=$FULL

export PROMPT_DIRTRIM=0

le=$?
function status() {
if [ "$le" -eq 0 ]
then
    echo "$GREEN✔$NIL"
else
    echo "$RED✗$NIL"
fi
}

# Prompt function because PROMPT_COMMAND is awesome
function set_prompt() {
    le=$?
    # show the host only and be done with it.
    host="${UC}${HD}${NIL}"

    # Special vim-tab-like shortpath (~/folder/directory/foo => ~/f/d/foo)
    _pwd=`pwd | sed "s#$HOME#~#"`
    if [[ $_pwd == "~" ]]; then
       _dirname=$_pwd
    #else
    #   _dirname=`dirname "$_pwd" `
    #    if [[ $_dirname == "/" ]]; then
    #          _dirname=""
    #    fi
    #   _dirname="$_dirname/`basename "$_pwd"`"
    fi
    path="${LC}${_dirname}${NIL}"
    myuser="${UC}\u@${NIL}"

    myuser="$CYAN\w$NIL"

    # Dirtiness from:
    # http://henrik.nyh.se/2008/12/git-dirty-prompt#comment-8325834
    if git update-index -q --refresh 2>/dev/null; git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null && git diff-files --quiet --ignore-submodules 2>/dev/null
        then dirty=""
    else
       dirty="${RED}*${NIL}"
    fi
    _branch=$(git symbolic-ref HEAD 2>/dev/null)
    _branch=${_branch#refs/heads/} # apparently faster than sed
    branch="" # need this to clear it when we leave a repo
    if [[ -n $_branch ]]; then
       branch=" ${NIL}[${PURPLE}${_branch}${dirty}${NIL}]"
    fi

    # Dollar/pound sign
    end="${LC}\$${NIL} "

    # Virtual Env
    if [[ $VIRTUAL_ENV != "" ]]
       then
           venv=" ${RED}(${VIRTUAL_ENV##*/})"
    else
       venv=''
    fi

    #export PS1="${myuser}${path}${venv}${branch} ${end}"
    export PS1="${myuser}${venv}${branch}${end}$(status) "
}

export PROMPT_COMMAND=set_prompt
alias night="xbacklight -set 10"
alias day="xbacklight -set 100"
alias lighter="xbacklight -inc 25"
alias darker="xbacklight -dec 25"
