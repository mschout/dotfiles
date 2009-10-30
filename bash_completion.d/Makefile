CONFIGS = \
	svn \
	git

include ../Mk/config.mk

default: all

all: $(CONFIGS)

INSTALL_DIR = $(HOME)/.bash_completion.d

install-file-%: %
	@install $(INSTALLOPTS) $* $(INSTALL_DIR)/$*
	@echo installed $*

diff-file-%: %
	@$(DIFF) -u $(INSTALL_DIR)/$* $*

# pull a dotfile from home into the repo
pull-file-%: %
	@install $(INSTALLOPTS) $(INSTALL_DIR)/$* $*
	@echo pulled $*

install-dirs:
	@[ -d $(INSTALL_DIR) ] || mkdir -p $(INSTALL_DIR)

install: install-dirs

include ../Mk/std-rules.mk
