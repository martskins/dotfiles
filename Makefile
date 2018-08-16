.PHONY: install clean all nvim languages alacritty rust go haskell cpp

all: clean
	ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
	ln -s ~/dotfiles/init.vim ~/.vimrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
	ln -s ~/dotfiles/ctags ~/.ctags

clean:
	rm -f ~/.ctags
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.vimrc
	rm -f ~/.tmux.conf
	rm -f ~/.config/alacritty/alacritty.yml

install: vimplug languages alacritty nvim

vimplug:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

languages: rust go haskell cpp

rust:
	curl https://sh.rustup.rs -sSf | sh
	rustup update
	rustup component add rls-preview rust-analysis rust-src

go:
	wget https://dl.google.com/go/go1.10.3.src.tar.gz /tmp/golang.tar.gz
	tar -C /usr/local -xzf /tmp/golang.tar.gz
	export PATH=$$PATH:/usr/local/go/bin

cpp:
	# MACOS
	#Copy bin/clangd to /usr/local/bin/
	#Copy lib/clang/«clang version»/include to /usr/local/lib/clang/«clang version»/
	#Copy include/c++/v1 to /usr/include/c++/

haskell:
	sudo apt-get install haskell-platform
	cabal install brittany --bindir=$$HOME/.cabal/bin # -w $PATH_TO_GHC_8_0

	# MACOS
	# Install from https://www.haskell.org/platform/#osx

alacritty:
	git clone https://github.com/jwilm/alacritty.git
	cd alacritty
	rustup override set stable
	rustup update stable
	cargo build --release

	# MACOS
	#make app
	#cp -r target/release/osx/Alacritty.app /Applications/

nvim:
	sudo apt-get install neovim

	# MACOS
	# brew install neovim
