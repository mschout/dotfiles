# standard makefile rules install, diff, pull
#
# your Makefile must define install-file-%, diff-file-%, pull-file-%

install: $(foreach f, $(CONFIGS), install-file-$(f)) $(SUBDIRS)

diff: $(foreach f, $(CONFIGS), diff-file-$(f)) $(SUBDIRS)

pull: $(foreach f, $(CONFIGS), pull-file-$(f)) $(SUBDIRS)

