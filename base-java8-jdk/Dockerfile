# The following image:
#
#  - Creates an 'app' user & group, in order to run the application with
#  unprivileged mode.
#
#  - Sets the home in the '/app' folder, where the application code is expected
#  to be, pretty much the way Heroku organizes a container's directory layout.
FROM maven:3.3-jdk-8
MAINTAINER Roberto Quintanilla <roberto.quintanilla@gmail.com>

################################################################################
# Setup the 'app' User & '/app' directory.

# Add the "app" user and group first to make sure their IDs get assigned
# consistently - we definitely like them to be both 1000, to match our
# workstation's user/group ID's.
# Also, we like the app user home directory to be '/app':
RUN cp /etc/default/useradd /etc/default/useradd.bak \
  && echo "HOME=" >> /etc/default/useradd \
  && useradd --create-home --shell /usr/sbin/nologin app \
  && rm -rf /etc/default/useradd \
  && mv /etc/default/useradd.bak /etc/default/useradd \
  && rm /app/.bash_logout /app/.bashrc /app/.profile
