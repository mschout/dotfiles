SUBDIRS = after/ftplugin \
	after/syntax \
	colors \
	compiler \
	doc \
	ftdetect \
	ftplugin \
	indent \
	plugin \
	syntax

default:
	@echo There is no default target.

dirs:
	@for dir in $(SUBDIRS) ; do \
		mkdir -p $(HOME)/.vim/$$dir ;\
	done

install: dirs
	@for dir in $(SUBDIRS) ; do \
		cp -Rv $$dir/* $(HOME)/.vim/$$dir ; \
	done
	cp filetype.vim $(HOME)/.vim
	cp vimrc $(HOME)/.vimrc
	cp gvimrc $(HOME)/.gvimrc
