
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

DOCS_DIR=./docs_build
DOCGEN=$(DOCS_DIR)/.slm/deps/docgen/bin/docgen
DEFS_DB=$(DOCS_DIR)/jsl_defs_db.dat

build-docgen: fetch-deps
	cd $(DOCS_DIR)
	$(SLM) build
	cd ..
	test -f $(DOCGEN)


DOC_PKGS_FILE := $(DOCS_DIR)/pkgs.txt
PKGS := $(shell cat ${DOC_PKGS_FILE} | xargs)

# This is likely not correct in the 
#   general case. In development - JITX_ROOT is set by `SLM_CONFIG` is not 
#   In production - JITX_ROOT is not set
JITX_ROOT := ${SLM_CONFIG}

test-docs: build-docgen

	$(STANZA) definitions-database $(JITX_ROOT)/stanza.proj -o $(DOCS_DIR)/jitx_runtime_db.dat
	$(STANZA) definitions-database ./stanza.proj -merge-with $(DOCS_DIR)/jitx_runtime_db.dat -o $(DEFS_DB)

	$(DOCGEN) generate $(DEFS_DB) -type mkdocs -pkgs $(PKGS) -standalone src -o $(DOCS_DIR)/docs


.PHONY: clean
clean:
	$(STANZA) clean
	rm -f $(CWD)/pkgs/*
	rm -f $(CWD)/test-pkgs/*

