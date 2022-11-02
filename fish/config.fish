jump shell fish | source

alias lg "lazygit"
alias kp "kubectl --context prod-aws --namespace"
alias kd "kubectl --context dev-merit --namespace"
alias gsmp "git checkout master; git pull"
alias gsc "git switch -c "
alias gs "git switch "
alias docker podman

# eval (minikube docker-env)

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/martin/.ghcup/bin $PATH # ghcup-env

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion