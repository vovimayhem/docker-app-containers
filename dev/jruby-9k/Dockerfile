FROM vovimayhem/app-dev:base-node-jruby-dep
MAINTAINER Roberto Quintanilla <roberto.quintanilla@gmail.com>

RUN apt-get update && apt-get install -y libc6-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV JRUBY_VERSION=9.0.0.0.pre2 JRUBY_SHA1=eca37f67ed13daf426f5e1f034209c4d0fb9ef10

RUN mkdir /opt/jruby \
  && curl -fSL https://s3.amazonaws.com/jruby.org/downloads/${JRUBY_VERSION}/jruby-bin-${JRUBY_VERSION}.tar.gz -o /tmp/jruby.tar.gz \
  && echo "$JRUBY_SHA1 /tmp/jruby.tar.gz" | sha1sum -c - \
  && tar -zx --strip-components=1 -f /tmp/jruby.tar.gz -C /opt/jruby \
  && rm /tmp/jruby.tar.gz \
  && update-alternatives --install /usr/local/bin/ruby ruby /opt/jruby/bin/jruby 1

ENV PATH /opt/jruby/bin:$PATH

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
