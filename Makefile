CONFIGS = \
	cshrc \
	gitconfig \
	login

INSTALLOPTS=-m 0644 -p
DIFF=colordiff

default: all

all: $(CONFIGS)

install-file-%: %
	@install $(INSTALLOPTS) $* $(HOME)/.$*
	@echo installed $*

install: $(foreach f, $(CONFIGS), install-file-$(f))

diff-file-%: %
	@$(DIFF) -u $(HOME)/.$* $*

diff: $(foreach f, $(CONFIGS), diff-file-$(f))

# pull a dotfile from home into the repo
pull-file-%: %
	@install $(INSTALLOPTS) $(HOME)/.$* $*
	@echo pulled $*

pull: $(foreach f, $(CONFIGS), pull-file-$(f))
