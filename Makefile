UNAME := $(shell uname)

.PHONY: install clean all link \
	languages rust go haskell cpp \
	nvim alacritty vimplug zsh brew \
	ctags grpc lazygit

link: clean
	ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
	ln -s ~/dotfiles/init.vim ~/.vimrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ifeq ($(UNAME), Linux)
	ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
else ifeq ($(UNAME), Darwin)
	ln -s ~/dotfiles/alacritty_darwin.yml ~/.config/alacritty/alacritty.yml
endif
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

languages: rust go haskell cpp python

git:
	sudo apt-get -y install git

rust:
	curl https://sh.rustup.rs -sSf | sh
	rustup update
	rustup component add rls-preview rust-analysis rust-src
	source ~/.cargo/env

go:
	wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz -O /tmp/golang.tar.gz
	sudo tar -C /usr/local -xzf /tmp/golang.tar.gz
	echo 'export PATH=$$PATH:/usr/local/go/bin' | cat ~/.zshrc -
	source ~/.zshrc
	go get github.com/matryer/moq
ifeq ($(UNAME), Linux)
	brew install dep
else ifeq ($(UNAME), Darwin)
	curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
endif

python:
	pip install --upgrade pip
	pip install autopep8 flake8 isort

cpp:
	# MACOS
	#Copy bin/clangd to /usr/local/bin/
	#Copy lib/clang/«clang version»/include to /usr/local/lib/clang/«clang version»/
	#Copy include/c++/v1 to /usr/include/c++/

haskell:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install haskell-platform
else ifeq ($(UNAME), Darwin)
	wget https://haskell.org/platform/download/8.4.3/Haskell%20Platform%208.4.3%20Core%2064bit-signed.pkg -O /tmp/haskell-platform.pkg
	open /tmp/haskell-platform.pkg
endif
	cabal update
	cabal install brittany --bindir=$$HOME/.cabal/bin # -w $PATH_TO_GHC_8_0
	echo 'export PATH="$$HOME/Library/Haskell/bin:$$PATH"' | cat ~/.zshrc


alacritty:
	cargo install --git https://github.com/jwilm/alacritty.git
#  git clone https://github.com/jwilm/alacritty.git /tmp/alacritty
#  rustup override set stable
#  rustup update stable

#ifeq ($(UNAME), Linux)
#  sudo apt-get install -y cmake build-essential pkg-config libfreetype6-dev libfontconfig1-dev xclip
#  cd /tmp/alacritty; cargo build --release
#  cp /tmp/alacritty/target/release/alacritty ~/usr/local/bin/alacritty
#else ifeq ($(UNAME), Darwin)
#  make app
#  cp -r /tmp/alacritty/target/release/osx/Alacritty.app /Applications/
#endif

nvim:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install neovim
else ifeq ($(UNAME), Darwin)
	brew install neovim
endif

zsh:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install zsh
	sh -c "$$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else ifeq ($(UNAME), Darwin)
	brew install zsh zsh-completions
endif


brew:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install exuberant-ctags
else ifeq ($(UNAME), Darwin)
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif

ctags:
ifeq ($(UNAME), Linux)
	sudo apt-get -y install exuberant-ctags
else ifeq ($(UNAME), Darwin)
	brew install --HEAD universal-ctags/universal-ctags/universal-ctags
endif

grpc:
	go get -u google.golang.org/grpc
	go get -u github.com/golang/protobuf/protoc-gen-go
	echo 'export PATH=$$PATH:$$GOPATH/bin' | cat ~/.zshrc -
	source ~/.zshrc

lazygit:
ifeq ($(UNAME), Linux)
	sudo add-apt-repository ppa:lazygit-team/daily
	sudo apt-get -y update
	sudo apt-get -y --allow-unauthenticated install lazygit
else ifeq ($(UNAME), Darwin)
	brew tap jesseduffield/lazygit
	brew install lazygit
endif
