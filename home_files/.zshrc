source ~/.bash_aliases

# Colors
COLOR_OFF="\[\e[0m\]"
BLACK="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34m\]"
MAGENTA="\[\e[0;35m\]"
PURPLE="\[\e[35;5;57m\]"
CYAN="\[\e[0;36m\]"
WHITE="\[\e[0;37m\]"

function prompt(){
    if [[ -n "$AUTO_VENV" ]]; then
        CWD=$(pwd);
        until [  -f .venv/bin/activate ] || [ "$(exec pwd)" = / ]; do
            cd ..;
        done
        if [[ -f .venv/bin/activate ]]; then
            CAND_VENV=$(pwd)/.venv;
        else
            CAND_VENV="";
        fi
        cd $CWD;
        if [[ -n "$VIRTUAL_ENV" ]] && [[ "$VIRTUAL_ENV" != "$CAND_VENV" ]]; then
            deactivate;
        fi
        if [[ -n "$CAND_VENV" ]] && [[ "$VIRTUAL_VENV" != "$CAND_VENV" ]]; then
            source $CAND_VENV/bin/activate;
        fi
    fi
}

AUTO_VENV=1
PROMPT_COMMAND=prompt

function venv_ps1(){
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="$(basename $(dirname ${VIRTUAL_ENV}))"
    else
        venv=""
    fi
    [[ -n "$venv" ]] && echo "($venv) "
}

[ -f ~/.git-completion.zsh ] && . ~/.git-completion.zsh
[ -f ~/.git-prompt.sh ] && . ~/.git-prompt.sh

_PS1_HOST=${GREEN}\\h${COLOR_OFF}
_PS1_WORKINGDIR=${YELLOW}\\w${COLOR_OFF}
_PS1_GIT_BRANCH=${CYAN}'$(__git_ps1)'${COLOR_OFF}
_PS1_VENV=${PURPLE}$'$(venv_ps1)'${COLOR_OFF}
_PS1_TIEM=${BLUE}\\D{%T}${COLOR_OFF}
export PS1="\n${_PS1_HOST}:${_PS1_WORKINGDIR}${_PS1_GIT_BRANCH} ${_PS1_VENV}\n[${_PS1_TIME}] :: "
export VIRTUAL_ENV_DISABLE_PROMPT=1
