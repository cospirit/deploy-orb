FROM alpine

RUN apk \
	--no-cache \
	--update \
  	add bash git curl parallel

# Install bats-core
RUN git clone https://github.com/bats-core/bats-core.git \
	&& cd bats-core \
	&& ./install.sh /usr/local \
	&& cd .. \
	&& rm -rf bats-core

# Install CirleCi cli
RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash

VOLUME /orb
WORKDIR /orb

CMD ["bash"]
