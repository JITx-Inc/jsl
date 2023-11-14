
STANZA=jstanza
CWD=$(shell pwd)

TEST_DIR=$(CWD)/tests

TABGEN=./tabgen/tabgen

$(TABGEN):
	(cd tabgen && make)

TWO_PIN_STZ=src/landpatterns/two-pin/SMT-table.stanza
TWO_PIN_CSV=$(TWO_PIN_STZ:stanza=csv)
TWO_PIN_NAME="jsl/landpatterns/two-pin/SMT-table"
$(TWO_PIN_STZ): $(TWO_PIN_CSV) tabgen
	$(TABGEN) generate $(TWO_PIN_CSV) -f $@ -pkg-name $(TWO_PIN_NAME) -force

FILLETS=src/landpatterns/leads/lead-fillets-table.stanza
FILLETS_CSV=$(FILLETS:stanza=csv)
FILLETS_NAME=jsl/landpatterns/leads/lead-fillets-table
$(FILLETS): $(FILLETS_CSV) tabgen
	$(TABGEN) generate $(FILLETS_CSV) -f $@ -pkg-name $(FILLETS_NAME) -force

build-tests: $(TWO_PIN_STZ) $(FILLETS)
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
