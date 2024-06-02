source ~/.bash_aliases

prompt(){
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

venv_ps1(){
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="$(basename $(dirname ${VIRTUAL_ENV}))"
    else
        venv=""
    fi
    [[ -n "$venv" ]] && echo "($venv) "
}

[ -f ~/.git-prompt.sh ] && . ~/.git-prompt.sh

NEWLINE=$'\n'
_PS1_HOST=%F{green}%m%F
_PS1_WORKINGDIR=%F{yellow}%1d%F
_PS1_GIT_BRANCH=%F{cyan}'$(__git_ps1)'%F
_PS1_VENV=%F{purple}$'$(venv_ps1)'%F
_PS1_TIME=%F{blue}%*%F
export PS1="${NEWLINE}${_PS1_HOST}:${_PS1_WORKINGDIR}${_PS1_GIT_BRANCH} ${_PS1_VENV}${NEWLINE}[${_PS1_TIME}] :: "
export VIRTUAL_ENV_DISABLE_PROMPT=1
setopt PROMPT_SUBST
