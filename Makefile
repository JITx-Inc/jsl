
STANZA=jstanza
CWD=$(shell pwd)

TEST_DIR=$(CWD)/tests

tabgen:
	(cd tabgen && make)

TABGEN=./tabgen/tabgen

FILLETS=src/landpatterns/leads/lead-fillets-table.stanza
FILLETS_CSV=$(FILLETS:stanza=csv)
FILLETS_NAME=jsl/landpatterns/leads/lead-fillets-table
$(FILLETS): $(FILLETS_CSV) tabgen
	$(TABGEN) generate $(FILLETS_CSV) -f $@ -pkg-name $(FILLETS_NAME) -force

build-tests: $(FILLETS)
	$(STANZA) build tests

tests: build-tests
	./jsl-tests

test-%: build-tests
	./jsl-tests -tagged $(@:test-%=%) | grep -v "SKIP" | awk NF

clean:
	$(STANZA) clean
	rm -f $(CWD)/pkgs/*
	rm -f $(CWD)/test-pkgs/*

.PHONY: clean tests
