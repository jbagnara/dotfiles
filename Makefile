DOTFILES	:= $(shell pwd)
CONF		:= $(HOME)/.config
SWAY		:= $(CONF)/sway
TERMITE	 := $(CONF)/termite
I3BLOCKS	:= $(SWAY)/i3blocks
VIM			:= $(HOME)/.vim

RM		  := rm -rf

.PHONY: all
all: sway termite vim bash

.PHONY: sway
sway: i3blocks
	mkdir -p $(SWAY)
	ln -fs $(DOTFILES)/sway/* $(SWAY)/

.PHONY: i3blocks
i3blocks:
	mkdir -p $(I3BLOCKS)
	ln -fs $(DOTFILES)/i3blocks/* $(I3BLOCKS)/

.PHONY: termite
termite:
	mkdir -p $(TERMITE)
	ln -fs $(DOTFILES)/termite/* $(TERMITE)/

.PHONY: vim
vim:
	mkdir -p $(VIM)
	ln -fs $(DOTFILES)/vim/* $(VIM)/

.PHONY: bash
bash:
	ln -fs $(DOTFILES)/bash/bashrc $(HOME)/.bashrc

.PHONY: clean
clean:
	$(RM) $(SWAY)
	$(RM) $(I3BLOCKS)
	$(RM) $(VIM)
	$(RM) $(TERMITE)
