FLUTTER_VERSION?=3.16.3
FLUTTER?= fvm flutter
RUN_VERSION?=--debug
FOLDER?= folder
PROJECT?= project
DESCRIPTION?= description

GREEN_COLOR=\033[32m
NO_COLOR=\033[0m

define print_color_message
	@echo "$(GREEN_COLOR)$(1)$(NO_COLOR)";
endef

##
## ---------------------------------------------------------------
## Installation
## ---------------------------------------------------------------
##

.PHONY: install
install: ## Install environment
	@$(call print_color_message,"Install environment")
	fvm install $(FLUTTER_VERSION)
	fvm use $(FLUTTER_VERSION)

##
## ---------------------------------------------------------------
## Flutter
## ---------------------------------------------------------------
##

.PHONY: devtools
devtools: ## Serving DevTools
	@$(call print_color_message,"Serving DevTools")
	$(FLUTTER) pub global run devtools

.PHONY: dependencies
dependencies: ## Update dependencies
	# make dependencies FOLDER=cookbooks PROJECT=animate_a_page_route_transition
	@$(call print_color_message,"Update dependencies")
	cd ./$(FOLDER)/$(PROJECT)/ && $(FLUTTER) pub get

.PHONY: run
run: ## Run project by default debug version
	# make run FOLDER=cookbooks PROJECT=animate_a_page_route_transition
	@$(call print_color_message,"Run project by default debug version")
	cd ./$(FOLDER)/$(PROJECT)/ && $(FLUTTER) run $(RUN_VERSION)

.PHONY: generate
generate: ## Generate a project
	# make generate FOLDER=cookbooks PROJECT=animate_a_page_route_transition DESCRIPTION="Animate a page route transition"
	@$(call print_color_message,"Generate a project")
	$(FLUTTER) create ./$(FOLDER)/$(PROJECT)/ \
		--description="$(DESCRIPTION)" \
      	--platforms=android \
      	--org="com.mancel.yann" \
	  	--project-name=$(PROJECT)

##
## ---------------------------------------------------------------
## scrcpy
## ---------------------------------------------------------------
##

.PHONY: mirror
mirror: ## Mirror screen with scrcpy
	@$(call print_color_message,"Mirror screen with scrcpy")
	scrcpy --max-size 1024 --window-title 'My device'

.PHONY: record
record: ## Record screen with scrcpy
	@$(call print_color_message,"Record screen with scrcpy")
	scrcpy --max-size 1024 --no-display --record "flutter_$(shell date +%Y%m%d-%H%M%S).mp4"

#
# ----------------------------------------------------------------
# Help
# ----------------------------------------------------------------
#

.DEFAULT_GOAL := help
.PHONY: help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN_COLOR)%-30s$(NO_COLOR) %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'