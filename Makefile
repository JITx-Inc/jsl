
SLM_STANZA ?= jstanza
STANZA := $(SLM_STANZA)
CWD := $(shell pwd)
SLM ?= slm

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
    jsl/tests/symbols/box-symbol          \
    jsl/tests/bundles                     \
    jsl/tests/pin-assignment              \
    jsl/tests/layerstack                  \
    jsl/tests/ensure                      \
    jsl/tests/via-structures              \
    jsl/tests/si/Microstrip               \
    jsl/tests/si/couplers                 \
    jsl/tests/si/signal-ends              \
    jsl/tests/design/introspection        \
    jsl/tests/design/E-Series             \
    jsl/tests/circuits/Network            \
    jsl/tests/math

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

fetch-deps:
	# This forces SLM to fetch the dependencies
	#  it will fail - but we don't care as longs as the
	#  deps get fetched.
	-$(SLM) build fetch-deps

.PHONY: tests
tests: fetch-deps
	$(STANZA) run-test $(JSL_TESTS)

.PHONY: test-%
test-%: fetch-deps
	$(STANZA) run-test $(JSL_TESTS) -tagged $(@:test-%=%) | grep -v "SKIP" | awk NF

.PHONY: clean
clean:
	$(STANZA) clean
	rm -f $(CWD)/pkgs/*
	rm -f $(CWD)/test-pkgs/*

