begin
    set --local AUTOJUMP_PATH /usr/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

if status is-interactive
and not set -q TMUX
    exec tmux new-session -A -s main
end

function fish_user_key_bindings
	fzf_key_bindings
end

alias ls "exa"
alias l "exa -l"
alias open "xdg-open"