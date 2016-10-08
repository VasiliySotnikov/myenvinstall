SHELL=/bin/bash
VIMDIR=$(HOME)/.vim
BACKUPDIR=$(HOME)/.vim_old


all:  distclean install vimconfig


collect:
	@echo "Collecting information from the current machine:"
	cp $(VIMDIR)/.vimrc ./.vim/.vimrc
	cp $(VIMDIR)/ftplugin/tex.vim ./.vim/ftplugin/tex.vim
	cp $(HOME)/.bashrc ./.bashrc
	cp $(HOME)/.config/xfce4/terminal/terminalrc ./.config/xfce4/terminal/terminalrc

install:
	cp .bashrc $(HOME)/.bashrc
	cp -r --parents .vim $(HOME)/
	cp -r --parents .dircolors $(HOME)/
	if [[ $(ps -h -o comm -p $PPID) == xfce4* ]]; then
	    cp -r --parents .config/xfce4/terminal/terminalrc $(HOME)/
	elif [ $(ps -h -o comm -p $PPID) == gnome* ]; then
	    ./gnomesolarized.sh
	fi
	ln -s $(VIMDIR)/.vimrc $(HOME)/.vimrc

vimconfig:
	cd $(VIMDIR)/vimconfig/
	./vimconfig.sh
	

distclean: 
	rm -rf $(BACKUPDIR)
	mv -f $(VIMDIR) $(BACKUPDIR)
	mv -f $(HOME)/.bashrc $(BACKUPDIR)/.basrc

