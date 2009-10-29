CONFIGS = \
	push-ssh-key \
	perl-module-version

include ../Mk/config.mk

# these files need to be executable change INSTALLOPTS
INSTALLOPTS = -m0755 -p
BINDIR = $(HOME)/bin

all: $(CONFIGS)

install-file-%: %
	@install $(INSTALLOPTS) $* $(BINDIR)/$*
	@echo installed bin/$*

install-dir-bin:
	@[ -d $(BINDIR) ] || install -d -m 0755 $(BINDIR)

install: install-dir-bin

diff-file-%: %
	$(DIFF) -u $(BINDIR)/$* $*

pull-file-%: %
	@install $(INSTALLOPTS) $(BINDIR)/$* $*

include ../Mk/std-rules.mk

