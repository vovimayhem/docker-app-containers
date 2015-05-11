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
#
FROM vovimayhem/app-dev:base-ruby
MAINTAINER Roberto Quintanilla <roberto.quintanilla@gmail.com>

################################################################################
# Building ruby
# - Taken almost entirely from https://github.com/docker-library/ruby

ENV RUBY_MAJOR 2.0
ENV RUBY_VERSION 2.0.0-p645
ENV RUBY_DOWNLOAD_SHA256 5e9f8effffe97cba5ef0015feec6e1e5f3bacf6ace78cd1cdf72708cd71cf4ab

# Some of ruby's build scripts are written in ruby. We'll purge this later in
# this RUN command to make sure our final image uses what we just built.
#
# Please note that unlike the official ruby image, we're enabling DTrace:
RUN apt-get update \
	&& apt-get install -y bison libgdbm-dev ruby systemtap-sdt-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/ruby \
	&& curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
	&& echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - \
	&& tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.gz \
	&& cd /usr/src/ruby \
	&& autoconf \
	&& ./configure --disable-install-doc --enable-dtrace \
	&& make -j"$(nproc)" \
	&& make install \
	&& apt-get purge -y --auto-remove bison libgdbm-dev ruby systemtap-sdt-dev \
	&& rm -r /usr/src/ruby

# Install bundler as system gem:
RUN gem install bundler --no-rdoc --no-ri

# Set the '/app/vendor/bundle' folder as the GEM_HOME - It will preserve
# the original gem paths - check it with 'gem env':
ENV GEM_HOME /app/vendor/bundle

# Set the image user as the unprivileged 'app' user:
USER app

# Set the image's working directory to the '/app' folder, which is the 'app'
# user's home:
WORKDIR /app

# Set BUNDLE_APP_CONFIG to GEM_PATH and set PATH to include app binaries:
ENV BUNDLE_APP_CONFIG=$GEM_HOME PATH=/app/bin:$GEM_HOME/bin:$PATH

CMD ["irb"]
