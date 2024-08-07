
SLM_STANZA ?= jstanza
STANZA := $(SLM_STANZA)
CWD := $(shell pwd)

# execute all lines of a target in one shell
.ONESHELL:

TEST_DIR := $(CWD)/tests

JSL_TESTS :=                              \
    jsl/tests/landpatterns/numbering      \
    jsl/tests/landpatterns/packages       \
    jsl/tests/landpatterns/pad-planner    \
    jsl/tests/landpatterns/SOIC           \
    jsl/tests/landpatterns/SON            \
    jsl/tests/landpatterns/IPC            \
    jsl/tests/landpatterns/BGA            \
    jsl/tests/landpatterns/protrusions    \
    jsl/tests/landpatterns/two-pin/SMT    \
    jsl/tests/landpatterns/two-pin/radial \
    jsl/tests/landpatterns/two-pin/axial  \
    jsl/tests/landpatterns/courtyard      \
    jsl/tests/landpatterns/VirtualLP      \
    jsl/tests/geometry                    \
    jsl/tests/landpatterns/QFN            \
    jsl/tests/symbols/SymbolNode          \
    jsl/tests/bundles                     \
    jsl/tests/pin-assignment              \
    jsl/tests/layerstack                  \
    jsl/tests/ensure                      \
    jsl/tests/via-structures              \
    jsl/tests/si/Microstrip               \
    jsl/tests/si/couplers                 \
    jsl/tests/si/signal-ends              \
    jsl/tests/design/introspection

TABGEN=./tabgen/tabgen

$(TABGEN):
	(cd tabgen && make)

.PHONY: tabgen
tabgen: $(TABGEN)

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

# remove any existing test failures log to prepare for the next run of tests
.PHONY: clean-test-failures-log
clean-test-failures-log:
	@rm -f .test-failures.log

# Run the tests in the list JSL_TESTS, then print the log of failures and exit with a return code
.PHONY: tests
tests: clean-test-failures-log $(JSL_TESTS)
	@echo
	echo "===="
	[ ! -f .test-failures.log ] || (cat .test-failures.log && false)

all-tests:
	$(STANZA) run-test $(JSL_TESTS)

# Run a single test out of the list of JSL_TESTS and add any failure result to the log
.PHONY: $(JSL_TESTS)
$(JSL_TESTS):
	@echo "===="
	echo "Running JSL test \"$@\""
	$(STANZA) run-test $@ || echo "FAIL: $@" >> .test-failures.log

.PHONY: test-%
test-%:
	echo "$@"
	./jsl-tests -tagged $(@:test-%=%) | grep -v "SKIP" | awk NF

.PHONY: clean
clean:
	$(STANZA) clean
	rm -f $(CWD)/pkgs/*
	rm -f $(CWD)/test-pkgs/*

