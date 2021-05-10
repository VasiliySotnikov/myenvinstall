SHELL=/bin/bash
VIMDIR=$(HOME)/.vim
BACKUPDIR=$(HOME)/.vim_old


all:  install vimconfig ctags mathematica setup_tmux

collect:
	@echo "Collecting information from the current machine:"
	cp $(VIMDIR)/.vimrc ./.vim/
	cp $(VIMDIR)/filetype.vim ./.vim/ || true
	cp $(VIMDIR)/spell/en.utf-8.add ./.vim/spell/ || true
	cp $(VIMDIR)/coc-settings.json ./.vim/ || true
	cp $(VIMDIR)/coc-setup.vim ./.vim/ || true
	cp -t ./.vim/ftplugin -- $(VIMDIR)/ftplugin/*.vim
	cp -r -t ./.vim/ -- $(VIMDIR)/after
	cp -r -t ./.vim/ -- $(VIMDIR)/UltiSnips
	cp $(HOME)/.bashrc ./.bashrc || true
	cp $(HOME)/.profile ./.profile || true
	cp $(HOME)/.gitconfig ./.gitconfig || true
	cp $(HOME)/.config/xfce4/terminal/terminalrc ./.config/xfce4/terminal/terminalrc
	#cp -r $(HOME)/.config/git ./.config/
	cp $(HOME)/.latexmkrc ./.latexmkrc || true
	cp $(HOME)/.tmux.conf ./.tmux.conf || true
	cp $(HOME)/.ssh/config ./.ssh/config || true
	cp $(HOME)/.Mathematica/Autoload/init.m ./.Mathematica/Autoload/init.m || true

install:
	cp .bashrc $(HOME)/.bashrc
	cp .profile $(HOME)/.profile
	cp .latexmkrc $(HOME)/.latexmkrc
	cp .gitconfig $(HOME)/.gitconfig
	cp .tmux.conf $(HOME)/.tmux.conf
	cp -r --parents .vim $(HOME)/
	./replace_home.py -f $(VIMDIR)/coc-settings.json
	cp -r --parents .dircolors $(HOME)/
	cp -r --parents .config/ $(HOME)/
	ln -sf $(VIMDIR)/.vimrc $(HOME)/.vimrc
	cp ./.ssh/config $(HOME)/.ssh/config || true
	ln -sf ./inkscape_beamer/inkscape_beamer.py $(HOME)/local/bin/inkscape_beamer.py

vimconfig: install
	@echo "Installing vim plugins:"
	-cd $(VIMDIR)/vimconfig/ && ./vimconfig.sh

ctags: install 
	./install_ctags.sh

mathematica: install
	mkdir -p $(HOME)/.Mathematica/Autoload/
	cp .Mathematica/Autoload/init.m $(HOME)/.Mathematica/Autoload/init.m

setup_tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || (cd ~/.tmux/plugins/tpm ; git pull)

distclean: 
	rm -rf $(BACKUPDIR)
	if [ -d $(VIMDIR) ]; then mv -f $(VIMDIR) $(BACKUPDIR); fi
	if [ -e $(HOME)/.bashrc ]; then mv -f $(HOME)/.bashrc $(BACKUPDIR)/.basrc; fi

diff:
	make collect
	git diff

cargo:
	cargo install ripgrep
	cargo install fd-find
	cargo install sd
	cargo install --locked bat
