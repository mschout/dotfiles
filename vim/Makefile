SUBDIRS = after/ftplugin \
	after/syntax \
	colors \
	compiler \
	doc \
	ftdetect \
	ftplugin \
	indent \
	plugin \
	syntax

CONFIGS = $(foreach d, $(SUBDIRS), $(wildcard $(d)/*))

VIMDIR = $(HOME)/.vim

include ../Mk/config.mk

all: $(CONFIGS) $(SUBDIRS)

$(VIMDIR)/%: %
	@echo installed $*
	@install $(INSTALLOPTS) $* $@

install-dirs:
	@for dir in $(SUBDIRS); do mkdir -p $(VIMDIR)/$$dir; done
	@[ -d $(HOME)/backup ] || mkdir $(HOME)/.backup

install: install-dirs $(foreach f, $(CONFIGS), $(VIMDIR)/$(f))
	@echo installed vimrc
	@install $(INSTALLOPTS) vimrc $(HOME)/.vimrc
	@echo installed gvimrc
	@install $(INSTALLOPTS) gvimrc $(HOME)/.gvimrc
	@echo installed filetype.vim
	@install $(INSTALLOPTS) filetype.vim $(VIMDIR)

diff:
	@for f in $(CONFIGS); do $(DIFF) $(VIMDIR)/$$f $$f; done

pull:
	@echo pull not supported for vim files
