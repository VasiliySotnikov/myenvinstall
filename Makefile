SHELL=/bin/bash
VIMDIR=$(HOME)/.vim
BACKUPDIR=$(HOME)/.vim_old


all:  install vimconfig


collect:
	@echo "Collecting information from the current machine:"
	cp $(VIMDIR)/.vimrc ./.vim/.vimrc
	cp $(VIMDIR)/ftplugin/tex.vim ./.vim/ftplugin/tex.vim
	cp $(HOME)/.bashrc ./.bashrc
	cp $(HOME)/.gitconfig ./.gitconfig
	cp $(HOME)/.config/xfce4/terminal/terminalrc ./.config/xfce4/terminal/terminalrc
	cp -r $(HOME)/.config/git ./.config/
	cp -r $(HOME)/.config/htop ./.config/

install:
	cp .bashrc $(HOME)/.bashrc
	cp .bash_profile $(HOME)/.bash_profile
	cp .gitconfig $(HOME)/.gitconfig
	cp -r --parents .vim $(HOME)/
	cp -r --parents .dircolors $(HOME)/
	cp -r --parents .config/ $(HOME)/
	ln -sf $(VIMDIR)/.vimrc $(HOME)/.vimrc

vimconfig:
	@echo "Installing vim plugins:"
	-cd $(VIMDIR)/vimconfig/ && ./vimconfig.sh
	

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
	#cp $(HOME)/.bash_profile ./.bash_profile
