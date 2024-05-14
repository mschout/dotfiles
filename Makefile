# dotfile configs install in $(HOME)/.$file
CONFIGS = \
	bash_profile \
	bashrc \
	bashrc.darwin \
	bashrc.freebsd \
	bashrc.linux \
	cshrc \
	ctags \
	cvsrc \
	gitconfig \
	gitignore \
	gitk \
	gvimrc \
	hushlogin \
	ideavimrc \
	inputrc \
	login \
	perltidyrc \
	plan \
	psqlrc \
	rpmmacros \
	signature \
	taskrc \
	vimrc

# subdirs installed in $(HOME)/.$dir
DOTDIRS = \
	bash_completion.d \
	bash_profile.d \
	dir_colors \
	fzf \
	fzf-extras \
	git_template \
	pandoc \
	subversion \
	m2 \
	dzil \
	vim

# subdirs installed in $(HOME)/$dir
DIRS = \
	bin

INSTALLOPTS=-m 0644 -p

DIFF=$(shell which colordiff 2>/dev/null || echo diff)

# which branch should be used for make dist.
# e.g.: make dist BRANCH=rhel5.  default is master branch
ifndef BRANCH
BRANCH = master
endif

default: all

all: $(CONFIGS)

dist:
	@git archive $(BRANCH) --prefix=dotfiles/ | gzip --best > dotfiles.tar.gz
	@echo created dotfiles.tar.gz from branch $(BRANCH)

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
	@find $* -type d | while read dir ; do install -d $$dir $(HOME)/.$$dir ; done
	@find $* -type f | while read file ; do install $(INSTALLOPTS) $$file $(HOME)/.$$file ; done
	@echo installed $*

link-dotdir-%: %
	@[ -e $(HOME)/.$* ] || ln -s $(patsubst $(HOME)/%,%,$(CURDIR)/$*) $(HOME)/.$*

link-dotfile-%: %
	@[ -e $(HOME)/.$* ] || ln -s $(patsubst $(HOME)/%,%,$(CURDIR)/$*) $(HOME)/.$*

install-dir-%: %
	@find $* -type d | while read dir ; do install -d $$dir $(HOME)/$$dir ; done
	@find $* -type f | while read file ; do install -m 0755 -p $$file $(HOME)/$$file ; done
	@echo installed $*

diff-file-%: %
	@-$(DIFF) -u $(HOME)/.$* $*

diff-dotdir-%: %
	-@-$(DIFF) -ur $(HOME)/.$* $*

diff-dir-%: %
	-@-$(DIFF) -ur $(HOME)/$* $*

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

