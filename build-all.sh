#! /bin/bash

echo "Building C-ish base images:" \
&& docker build --pull --rm -t vovimayhem/app:base base \
&& docker push vovimayhem/app:base \
&& docker build --rm -t vovimayhem/app:node-for-c-ish node-for-c-ish \
&& docker push vovimayhem/app:node-for-c-ish \
&& echo "Building & Pushing C-ish production-like images:" \
&& echo "  - Building & Pushing MRI 2.0:" \
&& docker build --rm -t vovimayhem/app:mri-2.0.0-p647 mri-2.0 \
&& docker push vovimayhem/app:mri-2.0.0-p647 \
&& docker tag -f vovimayhem/app:mri-2.0.0-p647 vovimayhem/app:mri-2.0.0 \
&& docker push vovimayhem/app:mri-2.0.0 \
&& docker tag -f vovimayhem/app:mri-2.0.0 vovimayhem/app:mri-2.0 \
&& docker push vovimayhem/app:mri-2.0 \
&& echo "  - Building & Pushing MRI 2.1:" \
&& docker build --rm -t vovimayhem/app:mri-2.1.7 mri-2.1 \
&& docker push vovimayhem/app:mri-2.1.7 \
&& docker tag -f vovimayhem/app:mri-2.1.7 vovimayhem/app:mri-2.1 \
&& docker push vovimayhem/app:mri-2.1 \
&& echo "  - Building & Pushing MRI 2.2:" \
&& docker build --rm -t vovimayhem/app:mri-2.2.3 mri-2.2 \
&& docker push vovimayhem/app:mri-2.2.3 \
&& docker tag -f vovimayhem/app:mri-2.2.3 vovimayhem/app:mri-2.2 \
&& docker push vovimayhem/app:mri-2.2 \
&& docker tag -f vovimayhem/app:mri-2.2 vovimayhem/app:mri-2 \
&& docker push vovimayhem/app:mri-2 \
&& docker tag -f vovimayhem/app:mri-2 vovimayhem/app:mri \
&& docker push vovimayhem/app:mri \
&& docker tag -f vovimayhem/app:mri vovimayhem/app:ruby \
&& docker push vovimayhem/app:ruby \
&& echo "Building & Pushing C-ish development images:" \
&& echo "  - Building & Pushing base image:" \
&& docker build --rm -t vovimayhem/app-dev:base-c-ish dev/base-c-ish \
&& docker push vovimayhem/app-dev:base-c-ish \
&& echo "  - Building & Pushing MRI 2.0 for Development:" \
&& docker build --rm -t vovimayhem/app-dev:mri-2.0.0-p647 dev/mri-2.0 \
&& docker push vovimayhem/app-dev:mri-2.0.0-p647 \
&& docker tag -f vovimayhem/app-dev:mri-2.0.0-p647 vovimayhem/app-dev:mri-2.0.0 \
&& docker push vovimayhem/app-dev:mri-2.0.0 \
&& docker tag -f vovimayhem/app-dev:mri-2.0.0-p647 vovimayhem/app-dev:mri-2.0 \
&& docker push vovimayhem/app-dev:mri-2.0 \
&& echo "  - Building & Pushing MRI 2.1 for Development:" \
&& docker build --rm -t vovimayhem/app-dev:mri-2.1.7 dev/mri-2.1 \
&& docker push vovimayhem/app-dev:mri-2.1.7 \
&& docker tag -f vovimayhem/app-dev:mri-2.1.7 vovimayhem/app-dev:mri-2.1 \
&& docker push vovimayhem/app-dev:mri-2.1 \
&& echo "  - Building & Pushing MRI 2.2 for Development:" \
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
&& docker build --rm -t vovimayhem/app:node-for-java-ish node-for-java-ish \
&& docker push vovimayhem/app:node-for-java-ish \
&& docker build --rm -t vovimayhem/app-dev:base-java-ish dev/base-java-ish \
&& docker push vovimayhem/app-dev:base-java-ish \
&& docker build --rm -t vovimayhem/app-dev:jruby-9k dev/jruby-9k \
&& docker push vovimayhem/app-dev:jruby-9k \
&& docker tag -f vovimayhem/app-dev:jruby-9k vovimayhem/app-dev:jruby \
&& docker push vovimayhem/app-dev:jruby
