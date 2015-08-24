#! /bin/bash

docker build --pull --rm -t vovimayhem/app:base base \
&& docker push vovimayhem/app:base \
&& docker build --rm -t vovimayhem/app-dev:base-ruby dev/base-ruby \
&& docker push vovimayhem/app-dev:base-ruby \
&& docker build --rm -t vovimayhem/app-dev:mri-2.0.0-p647 dev/mri-2.0 \
&& docker push vovimayhem/app-dev:mri-2.0.0-p647 \
&& docker tag -f vovimayhem/app-dev:mri-2.0.0-p647 vovimayhem/app-dev:mri-2.0.0 \
&& docker push vovimayhem/app-dev:mri-2.0.0 \
&& docker tag -f vovimayhem/app-dev:mri-2.0.0-p647 vovimayhem/app-dev:mri-2.0 \
&& docker push vovimayhem/app-dev:mri-2.0 \
&& docker build --rm -t vovimayhem/app-dev:mri-2.1.7 dev/mri-2.1 \
&& docker push vovimayhem/app-dev:mri-2.1.7 \
&& docker tag -f vovimayhem/app-dev:mri-2.1.7 vovimayhem/app-dev:mri-2.1 \
&& docker push vovimayhem/app-dev:mri-2.1 \
&& docker build --rm -t vovimayhem/app-dev:mri-2.2.3 dev/mri-2.2 \
&& docker push vovimayhem/app-dev:mri-2.2.3 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.3 vovimayhem/app-dev:mri-2.2 \
&& docker push vovimayhem/app-dev:mri-2.2 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.3 vovimayhem/app-dev:mri-2 \
&& docker push vovimayhem/app-dev:mri-2 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.3 vovimayhem/app-dev:mri \
&& docker push vovimayhem/app-dev:mri \
&& docker tag -f vovimayhem/app-dev:mri-2.2.3 vovimayhem/app-dev:ruby \
&& docker push vovimayhem/app-dev:ruby

# Java-ish:
docker build --pull --rm -t vovimayhem/app:base-java8-jdk base-java8-jdk \
&& docker push vovimayhem/app:base-java8-jdk \
&& docker build --pull --rm -t vovimayhem/app-dev:base-jruby dev/base-jruby \
&& docker push vovimayhem/app-dev:base-jruby \
&& docker build --pull --rm -t vovimayhem/app-dev:jruby-9k dev/jruby-9k \
&& docker push vovimayhem/app-dev:jruby-9k \
&& docker tag -f vovimayhem/app-dev:jruby-9k vovimayhem/app-dev:jruby \
&& docker push vovimayhem/app-dev:jruby
