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
	bash_completion.d \
	bin \
	subversion

include Mk/config.mk

default: all

all: $(CONFIGS) $(SUBDIRS)

install-file-%: %
	@install $(INSTALLOPTS) $* $(HOME)/.$*
	@echo installed $*

install-file-vim: vim
	@[ -d $(HOME)/.vim ] || mkdir $(HOME)/.vim
	@cp -pR vim/ $(HOME)/.vim/
	@echo installed vim files

install-file-bin: bin
	@[ -d $(HOME)/bin ] || mkdir $(HOME)/bin
	@cp -pR bin/ $(HOME)/bin/

install-file-subversion: subversion
	@[ -d $(HOME)/.subversion ] || mkdir $(HOME)/.subversion
	@cp -pR subversion/ $(HOME)/.subversion/
	@echo installed subversion files

install-file-bash_completion.d: bash_completion.d
	@echo installed $<
	@[ -d $(HOME)/.$< ] || mkdir $(HOME)/.$<
	@install $(INSTALLOPTS) $</* $(HOME)/.$<

diff-file-%: %
	@$(DIFF) -u $(HOME)/.$* $*

diff-file-vim: vim
	@$(DIFF) -ur $(HOME)/.vim vim

diff-file-bin: bin
	-@$(DIFF) -ur $(HOME)/bin bin

diff-file-subversion: subversion
	-@$(DIFF) -ur $(HOME)/.subversion subversion

diff-file-bash_completion.d: bash_completion.d
	-@$(DIFF) -ur $(HOME)/.$< $<

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

# pull subversion files. only pull files that are tracked by git.
pull-file-subversion: subversion
	@for file in subversion/*; do \
		[ -f $(HOME)/.$$file ] && cp -p $(HOME)/.$$file subversion ; \
	done
	@echo pulled subversion

pull-file-bash_completion.d: bash_completion.d
	@for file in $</*; do \
		[ -f $(HOME)/.$$file ] && cp -p $(HOME)/.$$file $< ; \
	done
	@echo pulled $<

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

include Mk/std-rules.mk
