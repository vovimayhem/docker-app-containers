FROM vovimayhem/app:base
MAINTAINER Roberto Quintanilla <roberto.quintanilla@gmail.com>

################################################################################
# Install Node & Watchman
#
# We'll include the current version of Node, as Javascript Interpreter:
#  - For asset precompilation: Some if not most of ruby development will involve
#  compiling javascript for web frontends (jQuery, Turbolinks, angular, ember, etc)
#
# Notes about the steps in the following RUN command:
#  1: We set the NodeJS and NPM versions as variables which won't be persisted
#     on the final image.
#  2: We use apt to install dependencies:
#       - python-dev, which is a dependency for compiling watchman
#  3: We add the GPG keys in order to validate the NodeJS download. See:
#       gpg: aka "Timothy J Fontaine (Work) <tj.fontaine@joyent.com>"
#       gpg: aka "Julien Gilli <jgilli@fastmail.fm>"
RUN NODE_VERSION=0.12.7 NPM_VERSION=2.13.4 \
  && echo "============ Installing Image Build Dependencies ============" \
  && apt-get update && apt-get install -y python-dev \
  && echo "===================== Installing NodeJS =====================" \
  && gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D \
  && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear \
  && echo "==================== Installing Watchman ====================" \
  && cd /tmp && git clone https://github.com/facebook/watchman.git \
  && cd watchman && ./autogen.sh && ./configure \
  && wget https://bootstrap.pypa.io/ez_setup.py -O - | python \
  && make && make install \
  && cd /tmp && rm -rf watchman \
  && echo "============= Cleaning Image Build Dependencies =============" \
  && cd /tmp && rm -rf ./* \
  && apt-get purge -y --auto-remove python-dev && rm -rf /var/lib/apt/lists/*

# Set the npm prefix to /app, so any globally installed package will be saved in
# /app/lib/node_modules folder:
ENV NPM_CONFIG_PREFIX=/app
