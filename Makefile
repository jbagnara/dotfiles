DOTFILES := $(shell pwd)

.PHONY: all
all: i3 termite vim bash

.PHONY: i3
i3:
	mkdir -p $(HOME)/.config/i3/i3blocks
	ln -fs $(DOTFILES)/i3config $(HOME)/.config/i3/config
	ln -fs $(DOTFILES)/i3blocks.conf $(HOME)/.config/i3/i3blocks.conf
	ln -fs $(DOTFILES)/i3blocks/* $(HOME)/.config/i3/i3blocks/

.PHONY: termite
termite:
	if [ ! -d "$(HOME)/termite" ]; then ln -fs $(DOTFILES)/termite $(HOME)/.config/termite; fi

.PHONY: vim
vim:
	ln -fs $(DOTFILES)/.vimrc $(HOME)/.vimrc

.PHONY: bash
bash:
	ln -fs $(DOTFILES)/.bashrc $(HOME)/.bashrc

.PHONY: clean
clean:
	rm $(HOME)/.config/i3/config
	rm $(HOME)/.config/i3/i3blocks.conf
	rm $(HOME)/.config/i3/i3blocks
	rm $(HOME)/.config/termite
	rm $(HOME)/.vimrc
	rm $(HOME)/.bashrc
