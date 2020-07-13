.PHONY: clean link

link: clean
	ln -s ~/dotfiles/.vim ~/
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/fish ~/.config/fish

clean:
	rm -f ~/.vim
	rm -f ~/.tmux.conf
	rm -f ~/.config/kitty/kitty.conf
	rm -f ~/.config/dunst/dunstrc
	rm -rf ~/.config/polybar
	rm -rf ~/.config/fish
	rm -rf ~/.config/i3
	rm -rf ~/.mozilla/firefox/4toh0cdd.dev-edition-default/chrome/userChrome.css
