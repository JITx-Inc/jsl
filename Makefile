
STANZA=jstanza
CWD=$(shell pwd)
TEST_DIR=$(CWD)/tests

build-tests:
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
