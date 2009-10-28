CONFIGS = \
	config

SVNDIR = $(HOME)/.subversion

include ../Mk/config.mk

all: $(CONFIGS)

install-file-%: %
	@install $(INSTALLOPTS) $* $(SVNDIR)/$*
	@echo installed subversion/$*

install-dir-subversion:
	@[ -d $(SVNDIR) ] || install -d -m 0775 $(SVNDIR)

install: install-dir-subversion

diff-file-%: %
	@$(DIFF) -u $(SVNDIR)/$* $*

pull-file-%: %
	@install $(INSTALLOPTS) $(SVNDIR)/$* $*
	@echo pulled $*

include ../Mk/std-rules.mk

