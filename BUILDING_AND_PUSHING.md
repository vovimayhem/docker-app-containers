# Building and Pushing (Notes to myself)

```bash

################################################################################
# Building C-ish Dependencies Images:

# 1: Base Image - We'll use the '--pull' option to always use the latest image:
docker build --pull --rm -t vovimayhem/app:base base \
&& docker push vovimayhem/app:base

# 2: NodeJS for C-ish common base images:
docker build --rm -t vovimayhem/app:node-for-c-ish node-for-c-ish \
&& docker push vovimayhem/app:node-for-c-ish

# 3: C-ish development base image, which declares `/app` as a volume, preventing
# further changes in this directory to persist:
docker build --rm -t vovimayhem/app-dev:base-c-ish dev/base-c-ish \
&& docker push vovimayhem/app-dev:base-c-ish \

################################################################################
# Ruby MRI (The 'Official' Ruby)
# We'll tag the current stable MRI as the 'official' ruby.

# 1: First, we'll build the MRI old stable, push it to the public registry, and tag it as
# mri-(major).(minor).(tiny), mri-(major)-(minor):
docker build --rm -t vovimayhem/app-dev:mri-2.0.0-p647 dev/mri-2.0 \
&& docker push vovimayhem/app-dev:mri-2.0.0-p647 \
&& docker tag -f vovimayhem/app-dev:mri-2.0.0-p647 vovimayhem/app-dev:mri-2.0.0 \
&& docker push vovimayhem/app-dev:mri-2.0.0 \
&& docker tag -f vovimayhem/app-dev:mri-2.0.0-p647 vovimayhem/app-dev:mri-2.0 \
&& docker push vovimayhem/app-dev:mri-2.0

# 2: Then we'll build the MRI previous stable, push it to the public registry,
# and tag it as mri-(major).(minor):
docker build --rm -t vovimayhem/app-dev:mri-2.1.7 dev/mri-2.1 \
&& docker push vovimayhem/app-dev:mri-2.1.7 \
&& docker tag -f vovimayhem/app-dev:mri-2.1.7 vovimayhem/app-dev:mri-2.1 \
&& docker push vovimayhem/app-dev:mri-2.1

# 3: Lastly, build the MRI current stable, push it to the public registry, and
# tag it as mri-(major).(minor), mri-(major), mri and ruby:
docker build --rm -t vovimayhem/app-dev:mri-2.2.3 dev/mri-2.2 \
&& docker push vovimayhem/app-dev:mri-2.2.3 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.3 vovimayhem/app-dev:mri-2.2 \
&& docker push vovimayhem/app-dev:mri-2.2 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.3 vovimayhem/app-dev:mri-2 \
&& docker push vovimayhem/app-dev:mri-2 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.3 vovimayhem/app-dev:mri \
&& docker push vovimayhem/app-dev:mri \
&& docker tag -f vovimayhem/app-dev:mri-2.2.3 vovimayhem/app-dev:ruby \
&& docker push vovimayhem/app-dev:ruby
```

## Java-ish Development Environments:

```bash
################################################################################
# Building Java-ish Dependencies Images

# 1: Java App Base Image:
docker build --pull --rm -t vovimayhem/app:base-java8-jdk base-java8-jdk \
&& docker push vovimayhem/app:base-java8-jdk

# 2: NodeJS for Java-ish common base images:
docker build --rm -t vovimayhem/app:node-for-java-ish node-for-java-ish \
&& docker push vovimayhem/app:node-for-java-ish

# 3: Java-ish development base image, which declares `/app` as a volume,
# preventing further changes in this directory to persist:
docker build --rm -t vovimayhem/app-dev:base-java-ish dev/base-java-ish \
&& docker push vovimayhem/app-dev:base-java-ish

################################################################################
# JRuby Development Images

# 1: JRuby 9000:
docker build --rm -t vovimayhem/app-dev:jruby-9k dev/jruby-9k \
&& docker push vovimayhem/app-dev:jruby-9k \
&& docker tag -f vovimayhem/app-dev:jruby-9k vovimayhem/app-dev:jruby \
&& docker push vovimayhem/app-dev:jruby
```
