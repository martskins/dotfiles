jump shell fish | source

alias lg "lazygit"
alias kp "kubectl --context prod-aws --namespace"
alias kd "kubectl --context dev-merit --namespace"
alias gsmp "git checkout (git remote show origin | sed -n '/HEAD branch/s/.*: //p') && git pull"
alias gsm "git checkout master | git checkout main"
alias gsc "git switch -c "
alias gs "git switch "
# alias docker colima
export DOCKER_HOST="unix:///Users/martin/.colima/default/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="/var/run/docker.sock"

# eval (minikube docker-env)

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/martin/.ghcup/bin $PATH # ghcup-env

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

status --is-interactive; and rbenv init - fish | source