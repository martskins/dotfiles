.PHONY: clean link

link: clean
	ln -s ~/dotfiles/nvim ~/.config/
	ln -s ~/dotfiles/init.vim ~/.vimrc
	ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
	ln -s ~/dotfiles/i3 ~/.config/i3
	ln -s ~/dotfiles/polybar ~/.config/polybar
	ln -s ~/dotfiles/fish ~/.config/fish
	ln -s ~/dotfiles/dunstrc ~/.config/dunst/dunstrc
	ln -s ~/dotfiles/userChrome.css ~/.mozilla/firefox/4toh0cdd.dev-edition-default/chrome/userChrome.css
	ln -s ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
	# ln -s ~/dotfiles/zshrc ~/.zshrc
	# ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

clean:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.vimrc
	rm -f ~/.tmux.conf
	rm -f ~/.config/kitty/kitty.conf
	rm -f ~/.config/dunst/dunstrc
	rm -rf ~/.config/polybar
	rm -rf ~/.config/fish
	rm -rf ~/.config/i3
	rm -rf ~/.mozilla/firefox/4toh0cdd.dev-edition-default/chrome/userChrome.css
	# rm -f ~/.config/alacritty/alacritty.yml
	# rm -rf ~/.zshrc
