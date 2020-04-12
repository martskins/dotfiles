begin
    set --local AUTOJUMP_PATH /usr/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

function fish_user_key_bindings
	fzf_key_bindings
end

alias screenkey "screenkey -g (slop -n -f '%g')"
alias ls "exa"
alias l "exa -l --git"
alias open "xdg-open"
alias lg "lazygit"

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gp='git pull'
alias gf='git fetch'
alias gd='git diff'
alias gco='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/gcloud/path.fish.inc' ]; . '/opt/gcloud/path.fish.inc'; end

# rvm default
# source /home/martin/.cache/pacaur/rvm/src/rvm/scripts/rvm

function fish_prompt
  set --local git_branch (git branch ^/dev/null | sed -n '/\* /s///p')
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color red
  if [ "$git_branch" = "" ]
    echo -n ' | '
  else
    echo -n ' ('"$git_branch"') | '
  end
end

fish_ssh_agent
