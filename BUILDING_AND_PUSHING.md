# Building and Pushing (Notes to myself)

```bash

################################################################################
# Building C-ish Dependencies Images:

# 1: Base Image - We'll use the '--pull' option to always use the latest image:
docker build --pull --rm -t vovimayhem/app:base base \
&& docker push vovimayhem/app:base

# 2: C-ish Ruby App Development Image, which only adds NodeJS:
docker build --rm -t vovimayhem/app-dev:base-ruby dev/base-ruby \
&& docker push vovimayhem/app-dev:base-ruby

################################################################################
# Ruby MRI (The 'Official' Ruby)
# We'll tag the current stable MRI as the 'official' ruby.

# 1: First, we'll build the MRI old stable, push it to the public registry, and tag it as
# mri-(major).(minor).(tiny), mri-(major)-(minor):
docker build --rm -t vovimayhem/app-dev:mri-2.0.0-p645 dev/mri-2.0 \
&& docker push vovimayhem/app-dev:mri-2.0.0-p645 \
&& docker tag -f vovimayhem/app-dev:mri-2.0.0-p645 vovimayhem/app-dev:mri-2.0.0 \
&& docker push vovimayhem/app-dev:mri-2.0.0 \
&& docker tag -f vovimayhem/app-dev:mri-2.0.0-p645 vovimayhem/app-dev:mri-2.0 \
&& docker push vovimayhem/app-dev:mri-2.0

# 2: Then we'll build the MRI previous stable, push it to the public registry,
# and tag it as mri-(major).(minor):
docker build --rm -t vovimayhem/app-dev:mri-2.1.6 dev/mri-2.1 \
&& docker push vovimayhem/app-dev:mri-2.1.6 \
&& docker tag -f vovimayhem/app-dev:mri-2.1.6 vovimayhem/app-dev:mri-2.1 \
&& docker push vovimayhem/app-dev:mri-2.1

# 3: Lastly, build the MRI current stable, push it to the public registry, and
# tag it as mri-(major).(minor), mri-(major), mri and ruby:
docker build --rm -t vovimayhem/app-dev:mri-2.2.2 dev/mri-2.2 \
&& docker push vovimayhem/app-dev:mri-2.2.2 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.2 vovimayhem/app-dev:mri-2.2 \
&& docker push vovimayhem/app-dev:mri-2.2 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.2 vovimayhem/app-dev:mri-2 \
&& docker push vovimayhem/app-dev:mri-2 \
&& docker tag -f vovimayhem/app-dev:mri-2.2.2 vovimayhem/app-dev:mri \
&& docker push vovimayhem/app-dev:mri \
&& docker tag -f vovimayhem/app-dev:mri-2.2.2 vovimayhem/app-dev:ruby \
&& docker push vovimayhem/app-dev:ruby
```

## Java-ish Development Environments:

```bash
################################################################################
# Building Java-ish Dependencies Images

# 1: Java App Base Image:
docker build --pull --rm -t vovimayhem/app:base-java8-jdk base-java8-jdk \
&& docker push vovimayhem/app:base-java8-jdk

# 2: JRuby App Development Image, which only adds NodeJS:
docker build --pull --rm -t vovimayhem/app-dev:base-jruby dev/base-jruby \
&& docker push vovimayhem/app-dev:base-jruby

################################################################################
# JRuby Development Images

# 1: JRuby 9000:
docker build --pull --rm -t vovimayhem/app-dev:jruby-9k dev/jruby-9k \
&& docker push vovimayhem/app-dev:jruby-9k \
&& docker tag -f vovimayhem/app-dev:jruby-9k vovimayhem/app-dev:jruby \
&& docker push vovimayhem/app-dev:jruby
```
