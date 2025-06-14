DOTFILES	:= $(shell pwd)
CONF		:= $(HOME)/.config
SWAY		:= $(CONF)/sway
TERMITE	    := $(CONF)/termite
I3BLOCKS	:= $(SWAY)/i3blocks
WAYBAR	    := $(CONF)/waybar
VIM			:= $(HOME)/.vim
NVIM		:= $(CONF)/nvim
TMUX		:= $(CONF)/tmux
FUZZEL		:= $(CONF)/fuzzel
QUTEBROWSER	:= $(CONF)/qutebrowser

RM		  := rm -rf

.PHONY: all
all: sway termite vim bash tmux fuzzel

.PHONY: sway
sway: waybar
	mkdir -p $(SWAY)
	ln -fs $(DOTFILES)/sway/* $(SWAY)/

.PHONY: waybar
waybar:
	mkdir -p $(WAYBAR)
	ln -fs $(DOTFILES)/waybar/* $(WAYBAR)/

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

.PHONY: nvim
nvim:
	mkdir -p $(VIM)
	ln -fs $(DOTFILES)/nvim/* $(NVIM)/

.PHONY: bash
bash:
	ln -fs $(DOTFILES)/bash/bashrc $(HOME)/.bashrc

.PHONY: tmux
tmux:
	mkdir -p $(TMUX)
	ln -fs $(DOTFILES)/tmux/* $(TMUX)/

.PHONY: fuzzel
fuzzel:
	mkdir -p $(FUZZEL)
	ln -fs $(DOTFILES)/fuzzel/* $(FUZZEL)/

.PHONY: qutebrowser
qutebrowser:
	mkdir -p $(QUTEBROWSER)
	ln -fs $(DOTFILES)/qutebrowser/* $(QUTEBROWSER)/

.PHONY: clean
clean:
	$(RM) $(SWAY)
	$(RM) $(I3BLOCKS)
	$(RM) $(VIM)
	$(RM) $(NVIM)
	$(RM) $(TERMITE)
	$(RM) $(TMUX)
	$(RM) $(FUZZEL)
	$(RM) $(QUTEBROWSER)
