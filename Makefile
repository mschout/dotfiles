# dotfile configs install in $(HOME)/.$file
CONFIGS = \
	bashrc \
	bashrc.darwin \
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
	signature \
	vimrc \
	gvimrc

# subdirs installed in $(HOME)/.$dir
DOTDIRS = \
	bash_completion.d \
	subversion \
	vim

# subdirs installed in $(HOME)/$dir
DIRS = \
	bin

INSTALLOPTS=-m 0644 -p

DIFF=$(shell which colordiff &>/dev/null && echo colordiff || echo diff)

default: all

all: $(CONFIGS)

install: $(foreach f, $(CONFIGS), install-file-$(f)) \
	$(foreach f, $(DOTDIRS), install-dotdir-$(f)) \
	$(foreach f, $(DIRS), install-dir-$(f))
	@[ -d $(HOME)/.backup ] || mkdir $(HOME)/.backup
	@echo installed ~/.backup

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
	@find $* -type d | while read dir ; do install -d -p $$dir $(HOME)/.$$dir ; done
	@find $* -type f | while read file ; do install $(INSTALLOPTS) $$file $(HOME)/.$$file ; done
	@echo installed $*

install-dir-%: %
	@find $* -type d | while read dir ; do install -d -p $$dir $(HOME)/$$dir ; done
	@find $* -type f | while read file ; do install -m 0755 -p $$file $(HOME)/$$file ; done
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
	@find $* -type f | while read file ; do install $(INSTALLOPTS) $(HOME)/.$$file $$file ; done
	@echo pulled $*

# pull directory.  only pull files that are tracked
pull-dir-%: %
	@find $* -type f | while read file ; do install $(INSTALLOPTS) $(HOME)/$$file $$file ; done
	@echo pulled $*

