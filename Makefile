.SILENT:

IMAGE=cospirit/deploy
DOCKER_CMD=docker run --rm -it -v $(shell pwd):/orb
BATS_CMD=$(DOCKER_CMD) $(IMAGE) bats --jobs $(BATS_JOBS)
BATS_JOBS=5
CIRCLECI_CMD=$(DOCKER_CMD) $(IMAGE) circleci --skip-update-check

# 1. filter main receipe name from args (https://stackoverflow.com/a/47008498)
# 2. exclude 'development@install' in remaining args for receipe chaining
# 3. exclude 'development@update' in remaining args for receipe chaining
# TODO find a better way to manage this exception
ifneq "$(filter development@test.bats,$(MAKECMDGOALS))" ""
	args := `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
	args := $(subst development@test.bats,,$(args))
else
	args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
endif

# this target avoid make to return an error of unknown target when an extra argument is passed
# https://stackoverflow.com/a/47008498
%:
	:

development@install: development@docker.build development@orb.pack
development@build: development@orb.validate development@orb.pack development@cs.lint development@test
development@test: development@test.bats

development@docker.build:
	docker build -t $(IMAGE) docker/

development@cs.lint:
	docker run --rm -it\
		-v $(shell pwd):/src/deployment \
		-w /src/deployment \
		singapore/lint-condo \
		yamllint src

	docker run --rm -it \
		-v $(shell pwd):/src \
		-w /src \
		koalaman/shellcheck-alpine:v0.7.1 \
		shellcheck \
			--exclude=SC2148 \
			--severity=style \
			--format=tty \
			./src/scripts/*.sh

development@test.bats:
	 $(BATS_CMD) src/tests/ #$(call args,'src/tests/')

development@orb.validate:
	$(CIRCLECI_CMD) orb validate src/@orb.yml

development@orb.pack:
	$(CIRCLECI_CMD) orb pack src/
