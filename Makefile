UNAME := $(shell uname)

.PHONY: install clean all link \
	languages rust go haskell cpp \
	nvim alacritty vimplug zsh brew \
	ctags grpc lazygit

link: clean
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

install: git brew zsh nvim vimplug ctags languages grpc alacritty lazygit

vimplug:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

languages: rust go haskell cpp

git:
	sudo apt-get -y install git

rust:
	curl https://sh.rustup.rs -sSf | sh
	rustup update
	rustup component add rls-preview rust-analysis rust-src
	source $$HOME/.cargo/env

go:
	wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz -O /tmp/golang.tar.gz
	sudo tar -C /usr/local -xzf /tmp/golang.tar.gz
	echo 'export PATH=$$PATH:/usr/local/go/bin' | cat ~/.zshrc -
	go get github.com/matryer/moq

cpp:
	# MACOS
	#Copy bin/clangd to /usr/local/bin/
	#Copy lib/clang/«clang version»/include to /usr/local/lib/clang/«clang version»/
	#Copy include/c++/v1 to /usr/include/c++/

haskell:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install haskell-platform
	cabal update
	cabal install brittany --bindir=$$HOME/.cabal/bin # -w $PATH_TO_GHC_8_0
else ifeq ($(UNAME), OSx)
	echo 'Dont\'t know how to install haskell in OSx'
	# Install from https://www.haskell.org/platform/#osx
endif


alacritty:
	git clone https://github.com/jwilm/alacritty.git -o /tmp/alacritty
	cd /tmp/alacritty
	rustup override set stable
	rustup update stable
	cargo build --release

ifeq ($(UNAME), Linux)
	cp target/release/alacritty ~/usr/local/bin/alacritty
else ifeq ($(UNAME), OSx)
	make app
	cp -r target/release/osx/Alacritty.app /Applications/
endif

nvim:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install neovim
else ifeq ($(UNAME), OSx)
	brew install neovim
endif

zsh:
	sudo apt-get -y install zsh
	sh -c "$$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install exuberant-ctags
else ifeq ($(UNAME), OSx)
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif

ctags:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install exuberant-ctags
else ifeq ($(UNAME), OSx)
	echo 'Dont\'t know how to install ctags in OSx'
endif

grpc:
	go get -u google.golang.org/grpc
	go get -u github.com/golang/protobuf/protoc-gen-go
	echo 'export PATH=$$PATH:$$GOPATH/bin' | cat ~/.zshrc -

lazygit:
ifeq ($(UNAME), Linux)
	sudo add-apt-repository ppa:lazygit-team/daily
	sudo apt-get -y update
	sudo apt-get -y install lazygit
else ifeq ($(UNAME), OSx)
	brew tap jesseduffield/lazygit
	brew install lazygit
endif
