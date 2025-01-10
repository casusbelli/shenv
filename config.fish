# fish shell config file

alias vim='/usr/bin/nvim'
alias rm='/usr/bin/rm -i'
alias open='gio open'
alias k8s='/usr/bin/kubectl'
alias ll='ls -lash'
alias gitpowerpull='git pull --all --tags --force; and git submodule sync ; and git submodule update --init --recursive'

if test -z (pgrep -x ssh-agent|tr -d '[:space:]')
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end

set -U -x GIT_EDITORnvim
