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
# Building rubinius

ENV RBX_VERSION=2.5.3 RBX_RELEASE_SHA1=c4323b9410a12e45c1c9da4a17607bd57ec1bb59

# Set UTF-8 locale (Won't build unless these locales are set like this):
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# The rubinius build script is written entirely in ruby. We'll purge this later
# in this RUN command to make sure our final image uses what we just built.
#
# Please note that unlike the official ruby image, we're enabling DTrace:
RUN apt-get update \
	&& apt-get install -y bison bundler libedit-dev libgdbm-dev llvm-dev ruby systemtap-sdt-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/src/ruby \
	&& curl -fSL -o ruby.tar.bz2 "https://github.com/rubinius/rubinius/releases/download/v$RBX_VERSION/rubinius-$RBX_VERSION.tar.bz2" \
	&& echo "$RBX_RELEASE_SHA1 *ruby.tar.bz2" | sha1sum -c - \
	&& tar -xjf ruby.tar.bz2 -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.bz2 \
	&& cd /usr/src/ruby \
	&& bundle \
	&& SHELL="/bin/bash" ./configure --prefix=/usr/local \
	&& rake install \
	&& SUDO_FORCE_REMOVE=yes apt-get purge -y --auto-remove bison bundler libedit-dev libgdbm-dev llvm-dev ruby systemtap-sdt-dev \
	&& rm -r /usr/src/ruby

# TODO: Fix the prefix path on the previous step!
ENV PATH /usr/local/rubinius/gems/bin:/usr/local/rubinius/bin:$PATH

# Bundler is already installed with Rubinius.

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
