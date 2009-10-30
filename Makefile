CONFIGS = \
	bashrc \
	bash_profile \
	cshrc \
	gitconfig \
	cvsrc \
	perltidyrc \
	inputrc \
	login

SUBDIRS = \
	subversion \
	bin \
	bash_completion.d

include Mk/config.mk

.PHONY: $(SUBDIRS)

default: all

all: $(CONFIGS) $(SUBDIRS)

install-file-%: %
	@install $(INSTALLOPTS) $* $(HOME)/.$*
	@echo installed $*

diff-file-%: %
	@$(DIFF) -u $(HOME)/.$* $*

# pull a dotfile from home into the repo
pull-file-%: %
	@install $(INSTALLOPTS) $(HOME)/.$* $*
	@echo pulled $*

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

include Mk/std-rules.mk
