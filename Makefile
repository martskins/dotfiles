UNAME := $(shell uname)

.PHONY: clean link

link: clean
	ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
	ln -s ~/dotfiles/vanilla.vim ~/.config/nvim/vanilla.vim
	ln -s ~/dotfiles/init.vim ~/.vimrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/.muttrc ~/.muttrc
	ln -s ~/dotfiles/.mutt ~/.mutt
	ln -s ~/dotfiles/.zshrc ~/.zshrc
	ln -s ~/dotfiles/.ctags ~/.ctags
ifeq ($(UNAME), Linux)
	ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
else ifeq ($(UNAME), Darwin)
	ln -s ~/dotfiles/alacritty_darwin.yml ~/.config/alacritty/alacritty.yml
endif

clean:
	rm -f ~/.ctags
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/vanilla.vim
	rm -f ~/.vimrc
	rm -f ~/.tmux.conf
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.muttrc
	rm -rf ~/.mutt
	rm -rf ~/.zshrc
