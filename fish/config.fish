# begin
#     set --local AUTOJUMP_PATH /usr/share/autojump/autojump.fish
#     if test -e $AUTOJUMP_PATH
#         source $AUTOJUMP_PATH
#     end
# end
# 
# function fish_user_key_bindings
# 	fzf_key_bindings
# end
# 
# alias screenkey "screenkey -g (slop -n -f '%g')"
# alias ls "exa"
# alias py.test-3 "py.test"
# alias l "exa -l --git"
# alias open "xdg-open"
# alias lg "lazygit"
# alias venv "virtualenv"
# 
# alias gs='git status '
# alias ga='git add '
# alias gb='git branch '
# alias gc='git commit'
# alias gp='git pull'
# alias gf='git fetch'
# alias gd='git diff'
# alias gco='git checkout '
# alias gk='gitk --all&'
# alias gx='gitx --all'
# 
# if [ -z "$SSH_AUTH_SOCK" ] ; then
#   eval `ssh-agent -s`
#   ssh-add
# end
