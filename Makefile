all: clean
	ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
	ln -s ~/dotfiles/init.vim ~/.vimrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

clean:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.vimrc
	rm -f ~/.tmux.conf
	rm -f ~/.config/alacritty/alacritty.yml

deps:
	rustup update
	rustup component add rls-preview rust-analysis rust-src
	
	####### MACOS ONLY #######
	# Get clangd.. somehow
	#Copy bin/clangd to /usr/local/bin/
	#Copy lib/clang/«clang version»/include to /usr/local/lib/clang/«clang version»/
	#Copy include/c++/v1 to /usr/include/c++/
