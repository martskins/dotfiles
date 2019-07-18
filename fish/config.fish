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
