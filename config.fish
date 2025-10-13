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

set -U -x GIT_EDITOR nvim
set -U -x EDITOR nvim

function shellai
    # Based off https://notes.suhaib.in/docs/tech/how-to/how-to-build-a-personal-dev-copilot-with-ollama-+-tmux-+-bash/
    set -l model "devstral"  # Default model. Change this to 'mistral', 'codellama', etc.
    set -g prompt ""
    set -l context_from_stdin false

    # Check if we're receiving input via a pipe
    if test (count (commandline -op)) -gt 0
        set -g context_from_stdin true
    end

    # If prompt is provided as arguments, use it
    if test (count $argv) -gt 0
        set -g prompt (string join " " $argv)
    else
        echo "No prompt found."
    end

    echo "Thinking..."  # User feedback

    # Execute ollama. Ollama handles combining prompt args with stdin content.
    if test "$context_from_stdin" = true
        # When stdin is present, ollama reads from it directly.
        # The prompt arguments are passed as the user's specific query.
        ollama run $model $prompt
    else
        # No stdin, just run with the prompt
        if test -z "$prompt"
            echo "Usage: shellai \"Your query here\""
            echo "Or: cat file.py | shellai \"Explain this code\""
            return 1
        end
        ollama run $model $prompt
    end
end
