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
	login

DOTDIRS = \
	bash_completion.d \
	subversion \
	vim

DIRS = \
	bin

INSTALLOPTS=-m 0644 -p

DIFF=colordiff

default: all

all: $(CONFIGS)

install: $(foreach f, $(CONFIGS), install-file-$(f)) \
	$(foreach f, $(DOTDIRS), install-dotdir-$(f)) \
	$(foreach f, $(DIRS), install-dir-$(f))

diff: $(foreach f, $(CONFIGS), diff-file-$(f)) \
	$(foreach f, $(DOTDIRS), diff-dotdir-$(f)) \
	$(foreach f, $(DIRS), diff-dir-$(f))

pull: $(foreach f, $(CONFIGS), pull-file-$(f)) \
	$(foreach f, $(DOTDIRS), pull-dotdir-$(f)) \
	$(foreach f, $(DIRS), pull-dir-$(f))

install-file-%: %
	@install $(INSTALLOPTS) $* $(HOME)/.$*
	@echo installed $*

install-dotdir-%: %
	@[ -d $(HOME)/.$* ] || mkdir $(HOME)/.$*
	@cp -pR $*/ $(HOME)/.$*
	@echo installed $*

install-dir-%: %
	@[ -d $(HOME)/$* ] || mkdir $(HOME)/$*
	@cp -pR $*/ $(HOME)/$*/
	@echo installed $*

diff-file-%: %
	@$(DIFF) -u $(HOME)/.$* $*

diff-dotdir-%: %
	-@$(DIFF) -ur $(HOME)/.$* $*

diff-dir-%: %
	-@$(DIFF) -ur $(HOME)/$* $*

# pull a dotfile from home into the repo
pull-file-%: %
	@install $(INSTALLOPTS) $(HOME)/.$* $*
	@echo pulled $*

# pull dotdir.  only pull files that are tracked
pull-dotdir-%: %
	@for file in $*/*; do \
		[ -f $(HOME)/.$$file ] && cp -p $(HOME)/.$$file $* ; \
	done
	@echo pulled $*

# pull directory.  only pull files that are tracked
pull-dir-%: %
	@for file in $*/*; do \
		[ -f $(HOME)/$$file ] && cp -p $(HOME)/$$file $* ; \
	done
	@echo pulled $*

