EMACS := emacs
DEPENDENCIES := flycheck dash reformatter
FIND_PKG_DIR = $(shell find -L ~/.emacs.d/elpa -type d -regex '.*/$1-[0-9.]*')
SEARCH_DIRS = $(foreach _,$(DEPENDENCIES),-L $(call FIND_PKG_DIR,$(_)))
COMPILE_CMD = $(EMACS) -Q -L . $(SEARCH_DIRS) \
	--eval '(setq byte-compile-error-on-warn t)' \
	-batch -f batch-byte-compile
EL_FILES := $(wildcard *.el)

.PHONY: test
test: ## Run regular test (default Emacs)
test: $(EL_FILES)
	$(COMPILE_CMD) $(EL_FILES)

.PHONY: clean
clean: ## Clean files
	rm *.elc

# Hooks

HOOKS := $(filter-out %~,$(wildcard hooks/*))
GIT_DIR := $(shell git rev-parse --git-dir)

.PHONY: hooks
hooks: ## Install helpful git hooks
hooks: $(foreach _,$(HOOKS),$(GIT_DIR)/hooks/$(notdir $(_)))

$(GIT_DIR)/hooks/%: hooks/%
	ln -s $(PWD)/$(<) $(@)

.PHONY: help
help: ## Show this help text
	$(info usage: make [target])
	$(info )
	$(info Available targets:)
	@awk -F ':.*?## *' '/^[^\t].+?:.*?##/ \
         {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
