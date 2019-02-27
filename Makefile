UNAME := $(shell uname)

.PHONY: clean link

link: clean
	ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
	ln -s ~/dotfiles/init.vim ~/.vimrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/zshrc ~/.zshrc
	ln -s ~/dotfiles/i3 ~/.config/i3
	ln -s ~/dotfiles/polybar ~/.config/polybar
	ln -s ~/dotfiles/dunstrc ~/.config/dunst/dunstrc
	ln -s ~/dotfiles/userChrome.css ~/.mozilla/firefox/4toh0cdd.dev-edition-default/chrome/userChrome.css
ifeq ($(UNAME), Linux)
	ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
else ifeq ($(UNAME), Darwin)
	ln -s ~/dotfiles/alacritty_darwin.yml ~/.config/alacritty/alacritty.yml
endif

clean:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.vimrc
	rm -f ~/.tmux.conf
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.config/dunst/dunstrc
	rm -rf ~/.zshrc
	rm -rf ~/.config/polybar
	rm -rf ~/.config/i3
	rm -rf ~/.mozilla/firefox/4toh0cdd.dev-edition-default/chrome/userChrome.css
