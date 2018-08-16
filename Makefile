UNAME := $(shell uname)

.PHONY: install clean all \
	languages rust go haskell cpp \
	nvim alacritty vimplug zsh brew \
	ctags grpc lazygit

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

install: brew zsh nvim vimplug ctags languages grpc alacritty lazygit

vimplug:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

languages: rust go haskell cpp

rust:
	curl https://sh.rustup.rs -sSf | sh
	rustup update
	rustup component add rls-preview rust-analysis rust-src

go:
	wget https://dl.google.com/go/go1.10.3.src.tar.gz -O /tmp/golang.tar.gz
	tar -C /usr/local -xzf /tmp/golang.tar.gz
	go get github.com/matryer/moq
	echo 'PATH=$PATH:/usr/local/go/bin' | cat ~/.zshrc -

cpp:
	# MACOS
	#Copy bin/clangd to /usr/local/bin/
	#Copy lib/clang/«clang version»/include to /usr/local/lib/clang/«clang version»/
	#Copy include/c++/v1 to /usr/include/c++/

haskell:
ifeq ($(UNAME), Linux)
	sudo apt-get install haskell-platform
	cabal install brittany --bindir=$$HOME/.cabal/bin # -w $PATH_TO_GHC_8_0
else ifeq ($(UNAME), OSx)
	echo 'Dont\'t know how to install haskell in OSx'
	# Install from https://www.haskell.org/platform/#osx
endif


alacritty:
	git clone https://github.com/jwilm/alacritty.git
	cd alacritty
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
	sudo apt-get install neovim
else ifeq ($(UNAME), OSx)
	brew install neovim
endif

zsh:
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew:
ifeq ($(UNAME), Linux)
	sudo apt-get install exuberant-ctags
else ifeq ($(UNAME), OSx)
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif

ctags:
ifeq ($(UNAME), Linux)
	sudo apt-get install exuberant-ctags
else ifeq ($(UNAME), OSx)
	echo 'Dont\'t know how to install ctags in OSx'
endif

grpc:
	go get -u google.golang.org/grpc
	go get -u github.com/golang/protobuf/protoc-gen-go
	echo 'PATH=$PATH:$GOPATH/bin' | cat ~/.zshrc -

lazygit:
ifeq ($(UNAME), Linux)
	sudo add-apt-repository ppa:lazygit-team/daily
	sudo apt-get update
	sudo apt-get install lazygit
else ifeq ($(UNAME), OSx)
	brew tap jesseduffield/lazygit
	brew install lazygit
endif
