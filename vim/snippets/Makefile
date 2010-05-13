TARGETS = tt2html.snippets \
	tt2javascript.snippets

all: $(TARGETS)

clean:
	rm -f $(TARGETS)

tt2html.snippets: tt2html.snippets.in tt2.snippets html.snippets
	@echo generating $@
	@cat $^ > $@

tt2javascript.snippets: tt2.snippets javascript.snippets
	@echo generating $@
	@cat $^ > $@
