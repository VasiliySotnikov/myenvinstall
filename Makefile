SHELL=/bin/bash
VIMDIR=$(HOME)/.vim
BACKUPDIR=$(HOME)/.vim_old


all:  install vimconfig ctags mathematica


collect:
	@echo "Collecting information from the current machine:"
	cp $(VIMDIR)/.vimrc ./.vim/.vimrc
	cp $(VIMDIR)/filetype.vim ./.vim/filetype.vim || true
	cp -t ./.vim/ftplugin -- $(VIMDIR)/ftplugin/*.vim
	cp -r -t ./.vim/ -- $(VIMDIR)/after
	cp $(HOME)/.bashrc ./.bashrc
	cp $(HOME)/.gitconfig ./.gitconfig
	cp $(HOME)/.config/xfce4/terminal/terminalrc ./.config/xfce4/terminal/terminalrc
	cp -r $(HOME)/.config/git ./.config/
	cp $(HOME)/.latexmkrc ./.latexmkrc
	cp $(HOME)/.tmux.conf ./.tmux.conf
	cp $(HOME)/.ssh/config ./.ssh/config || true

install: mathematica
	cp .bashrc $(HOME)/.bashrc
	cp .latexmkrc $(HOME)/.latexmkrc
	cp .gitconfig $(HOME)/.gitconfig
	cp .tmux.conf $(HOME)/.tmux.conf
	cp -r --parents .vim $(HOME)/
	cp -r --parents .dircolors $(HOME)/
	cp -r --parents .config/ $(HOME)/
	ln -sf $(VIMDIR)/.vimrc $(HOME)/.vimrc
	cp ./.ssh/config $(HOME)/.ssh/config || true

vimconfig:
	@echo "Installing vim plugins:"
	-cd $(VIMDIR)/vimconfig/ && ./vimconfig.sh

ctags:
	./install_ctags.sh

mathematica:
	./MathematicaNotebookSave.sh

setup_tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


distclean: 
	rm -rf $(BACKUPDIR)
	if [ -d $(VIMDIR) ]; then mv -f $(VIMDIR) $(BACKUPDIR); fi
	if [ -e $(HOME)/.bashrc ]; then mv -f $(HOME)/.bashrc $(BACKUPDIR)/.basrc; fi

diff:
	make collect
	git diff


#if [[ $(ps -h -o comm -p ($PPID)) == xfce4* ]]; then \
    cp -r --parents .config/xfce4/terminal/terminalrc $(HOME)/
#elif [ $(ps -h -o comm -p ($PPID)) == gnome* ]; then \
    #./gnomesolarized.sh
#fi
