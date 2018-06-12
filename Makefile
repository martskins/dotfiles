all:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.vimrc
	rm -f ~/.tmux.conf
	ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
	ln -s ~/dotfiles/nvim/init.vim ~/.vimrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
