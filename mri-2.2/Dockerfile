# The following image is heavily influenced by the docker-library official ruby
# image (You can see the original source at https://github.com/docker-library/ruby).
#
# However, There are some key differences:
#
#  - Is based on vovimayhem/app:base, which creates an 'app' user & group, in
#  order to run the application with unprivileged access and sets the home in
#  the '/app' folder, where the application code is expected to be, pretty much
#  the way Heroku organizes a container's directory layout.
#
#  - Builds Ruby with dtrace enabled, making this image ideal for development
#  environments. Please note that because of this, these images are not
#  necessarily optimal for production environments.
#
#  - Sets the GEM_HOME directory to the '/app/vendor/bundle' folder, so gems
#  can be inspected by the developer & provided by mounting the app in the
#  volume.
FROM vovimayhem/app:node-for-c-ish
MAINTAINER Roberto Quintanilla <roberto.quintanilla@gmail.com>

################################################################################
# Building ruby
# - Taken almost entirely from https://github.com/docker-library/ruby
#
# Some of ruby's build scripts are written in ruby. We'll purge this later in
# this RUN command to make sure our final image uses what we just built.
#
# Please note that unlike the official ruby image, we're:
#  - Compiling ruby with DTrace enabled.
#  - Installing bundler as a system gem as part of the build step.
#  - Setting the '/app/vendor/bundle' as the GEM_HOME variable
#  - Adding '/app/bin' and '/app/vendor/bundle/bin' to the PATH variable
RUN RUBY_MAJOR=2.2 RUBY_VERSION=2.2.3 RUBYGEMS_VERSION=2.4.8 \
	RUBY_DOWNLOAD_SHA256=df795f2f99860745a416092a4004b016ccf77e8b82dec956b120f18bdc71edce \
	&& apt-get update \
	&& apt-get install -y bison libgdbm-dev ruby \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/ruby \
	&& curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
	&& echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - \
	&& tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.gz \
	&& cd /usr/src/ruby \
	&& autoconf \
	&& ./configure --disable-install-doc \
	&& make -j"$(nproc)" \
	&& make install \
	&& apt-get purge -y --auto-remove bison libgdbm-dev ruby \
	&& gem update --system $RUBYGEMS_VERSION \
	&& cd / && rm -r /usr/src/ruby \
	&& gem install bundler --no-rdoc --no-ri

################################################################################
# Persisted Environment Variables:
#  1: Set the GEM_HOME to the app's /app/vendor/bundle path. (It will preserve
#     the original gem paths - check it with 'gem env')
#  2: The path to the directory where bundler will store the local configuration.
#  3: Prepend the following paths to $PATH:
#      - The app's vendored gem binaries
#      - The app's binaries
ENV GEM_HOME=/app/vendor/bundle \
	BUNDLE_APP_CONFIG=/app/vendor/bundle \
	PATH=/app/bin:/app/vendor/bundle/bin:$PATH

# Set the image's working directory to the '/app' folder, which is the 'app'
# user's home:
WORKDIR /app

################################################################################
# Copy the current context folder (which should include the app's code + Gemfile)
ONBUILD ADD . /app
ONBUILD RUN chown -R app /app

# Run bundle install on build:
ONBUILD RUN bundle install --without development test

# Set the image user as the unprivileged 'app' user:
# ONBUILD USER app
################################################################################

CMD ["irb"]
