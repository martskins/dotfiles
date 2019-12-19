begin
    set --local AUTOJUMP_PATH /usr/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

function fish_user_key_bindings
	fzf_key_bindings
end

alias ls "exa"
alias l "exa -l"
alias open "xdg-open"
alias lg "lazygit"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/gcloud/path.fish.inc' ]; . '/opt/gcloud/path.fish.inc'; end

# rvm default
# source /home/martin/.cache/pacaur/rvm/src/rvm/scripts/rvm

function fish_prompt
  set --local git_branch (git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)

  echo -n (prompt_pwd)
  set_color red
  if [ "$git_branch" = "" ]
    echo -n ' | '
  else
    echo -n ' ('"$git_branch"') | '
  end
end
