PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})";


prompt_command () {
    if [ $? -eq 0 ]; then # set an error string for the prompt, if applicable
        ERRPROMPT=" "
    else
        ERRPROMPT='->($?) '
    fi
    local TIME=`fmt_time` # format time for prompt string
    local LOAD=`uptime|awk '{min=NF-2;print $min}'`
    local DIM="\[\033[0;2m\]"
    local GREEN="${DIM}\[\033[0;32m\]"
    local CYAN="${DIM}\[\033[0;36m\]"
    local BCYAN="${DIM}\[\033[1;36m\]"
    local BLUE="${DIM}\[\033[0;34m\]"
    local GRAY="${DIM}\[\033[0;37m\]"
    local WHITE="${DIM}\[\033[1;37m\]"
    local DKGRAY="${DIM}\[\033[1;30m\]"
    local RED="${DIM}\[\033[0;31m\]"
    # return color to Terminal setting for text color
    local DEFAULT="\[\033[0;39m\]"
    # set the titlebar to the last 2 fields of pwd
    local TITLEBAR='\[\e]2;`pwdtail`\a'
#    export PS1="\n\[${TITLEBAR}\]${CYAN}[ ${BCYAN}\u${GREEN}@${BCYAN}\
#\h ${bldblk}(${LOAD}) ${WHITE}${TIME} ${CYAN}]${RED}$ERRPROMPT${WHITE}\
#\w\n${GREEN}${BRANCH}${WHITE}>>${DEFAULT} "

    export PS1="\n\[${TITLEBAR}\]${CYAN}[ ${DKGRAY}`pwdtail` ${WHITE}${TIME} ${CYAN}]${RED}$ERRPROMPT${WHITE}\
\n${GREEN}${BRANCH}${RED}>>${DEFAULT} ";
    export PS2="${GRAY} >${DEFAULT} ";
}
PROMPT_COMMAND=prompt_command

fmt_time () { #format time just the way I likes it
    if [ `date +%p` = "PM" ]; then
        meridiem="pm"
    else
        meridiem="am"
    fi
    date +"%l:%M:%S$meridiem"|sed 's/ //g'
}
pwdtail () { #returns the last 2 fields of the working directory
    pwd|awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}
chkload () { #gets the current 1m avg CPU load
    local CURRLOAD=`uptime|awk '{print $8}'`
    if [ "$CURRLOAD" > "1" ]; then
        local OUTP="HIGH"
    elif [ "$CURRLOAD" < "1" ]; then
        local OUTP="NORMAL"
    else
        local OUTP="UNKNOWN"
    fi
    echo $CURRLOAD
}
