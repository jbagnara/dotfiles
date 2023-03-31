DOTFILES	:= $(shell pwd)
CONF		:= $(HOME)/.config
SWAY		:= $(CONF)/sway
TERMITE	 := $(CONF)/termite
I3BLOCKS	:= $(SWAY)/i3blocks
VIM			:= $(HOME)/.vim
TMUX		:= $(CONF)/tmux

RM		  := rm -rf

.PHONY: all
all: sway termite vim bash tmux

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

.PHONY: tmux
tmux:
	mkdir -p $(TMUX)
	ln -fs $(DOTFILES)/tmux/* $(TMUX)/

.PHONY: clean
clean:
	$(RM) $(SWAY)
	$(RM) $(I3BLOCKS)
	$(RM) $(VIM)
	$(RM) $(TERMITE)
	$(RM) $(TMUX)
