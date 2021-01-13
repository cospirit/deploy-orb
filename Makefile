.SILENT:

IMAGE=cospirit/deploy:latest
DOCKER_CMD=docker run --rm -it -v $(shell pwd):/orb $(IMAGE)
BATS_CMD=$(DOCKER_CMD) bats --jobs $(BATS_JOBS)
BATS_JOBS=5
CIRCLECI_CMD=$(DOCKER_CMD) circleci --skip-update-check

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
development@test: development@test.bats

development@docker.build:
	docker build -t $(IMAGE) docker/

development@test.bats:
	 $(BATS_CMD) src/tests/ #$(call args,'src/tests/')

development@orb.validate:
	$(CIRCLECI_CMD) orb validate src/@orb.yml

development@orb.pack:
	$(CIRCLECI_CMD) orb pack src/
