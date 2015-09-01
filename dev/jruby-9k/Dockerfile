# The following image is heavily influenced by the docker-library official jruby
# image (You can see the original source at https://github.com/cpuguy83/docker-jruby).
#
# However, There are some key differences:
#
#  - Is based on vovimayhem/app:base, which creates an 'app' user and group, in
#  order to run the application with unprivileged access and sets the home in
#  the '/app' folder, where the application code is expected to be, pretty much
#  the way Heroku organizes a container's directory layout.
#
#  - Should build JRuby with DTrace enabled, making this image ideal for development
#  environments. Please note that because of this, these images are not
#  necessarily optimal for production environments.
#
#  - Sets the GEM_HOME directory to the '/app/vendor/bundle' folder, so gems
#  can be inspected by the developer and provided by mounting the app in the
#  volume.
#
FROM vovimayhem/app:node-for-java-ish
MAINTAINER Roberto Quintanilla <roberto.quintanilla@gmail.com>

RUN JRUBY_VERSION=9.0.0.0 JRUBY_SHA256=655665db3a1dc0462cba99d45532ab57d8416b5f168d8a0081bde9b7a93a394e \
  && apt-get update \
  && apt-get install -y libc6-dev --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /opt/jruby \
  && curl -fSL https://s3.amazonaws.com/jruby.org/downloads/${JRUBY_VERSION}/jruby-bin-${JRUBY_VERSION}.tar.gz -o /tmp/jruby.tar.gz \
  && echo "$JRUBY_SHA256 /tmp/jruby.tar.gz" | sha256sum -c - \
  && tar -zx --strip-components=1 -f /tmp/jruby.tar.gz -C /opt/jruby \
  && rm /tmp/jruby.tar.gz \
  && update-alternatives --install /usr/local/bin/ruby ruby /opt/jruby/bin/jruby 1 \
  && PATH=/opt/jruby/bin:$PATH gem install bundler --no-rdoc --no-ri

################################################################################
# Persisted Environment Variables:
#  1: Set the GEM_HOME to the app's /app/vendor/bundle path. (It will preserve
#     the original gem paths - check it with 'gem env')
#  2: The path to the directory where bundler will store the local configuration.
#  3: Prepend the following paths to $PATH:
#      - The JRuby binaries
#      - The app's vendored gem binaries
#      - The app's binaries
ENV GEM_HOME=/app/vendor/bundle \
	BUNDLE_APP_CONFIG=/app/vendor/bundle \
	PATH=/app/bin:/app/vendor/bundle/bin:/opt/jruby/bin:$PATH

# Set the image user as the unprivileged 'app' user:
USER app

# Set the image's working directory to the '/app' folder, which is the 'app'
# user's home:
WORKDIR /app

CMD ["irb"]
