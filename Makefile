CONFIGS = \
	bashrc \
	bash_profile \
	cshrc \
	gitconfig \
	cvsrc \
	perltidyrc \
	inputrc \
	hushlogin \
	gitk \
	plan \
	login \
	vim \
	bin

SUBDIRS = \
	subversion \
	bash_completion.d

include Mk/config.mk

.PHONY: $(SUBDIRS)

default: all

all: $(CONFIGS) $(SUBDIRS)

install-file-%: %
	@install $(INSTALLOPTS) $* $(HOME)/.$*
	@echo installed $*

install-file-vim: vim
	@[ -d $(HOME)/.vim ] || mkdir $(HOME)/.vim
	@cp -R vim/ $(HOME)/.vim/
	@echo installed vim files

install-file-bin: bin
	@[ -d $(HOME)/bin ] || mkdir $(HOME)/bin
	@cp -R bin/ $(HOME)/bin/

diff-file-%: %
	@$(DIFF) -u $(HOME)/.$* $*

diff-file-vim: vim
	@$(DIFF) -uR $(HOME)/.vim vim

diff-file-bin: bin
	@$(DIFF) -ur $(HOME)/bin bin

# pull a dotfile from home into the repo
pull-file-%: %
	@install $(INSTALLOPTS) $(HOME)/.$* $*
	@echo pulled $*

pull-file-vim: vim
	@cp -R $(HOME)/.vim/ vim/
	@echo pulled vim

# pull bin files. only pull files that are tracked by git.
pull-file-bin: bin
	@for file in bin/*; do \
		[ -f $(HOME)/$$file ] && cp -p $(HOME)/$$file bin ; \
	done
	@echo pulled bin

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

include Mk/std-rules.mk
