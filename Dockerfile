FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential
RUN mkdir /gatekeeper-client
WORKDIR /gatekeeper-client
ADD . /gatekeeper-client
RUN /bin/bash -c "cd /gatekeeper-client && bundle update"