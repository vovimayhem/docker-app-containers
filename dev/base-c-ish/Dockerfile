# This Dockerfile creates a base image required for all C-ish ruby Docker containers.
# The only extra functionality is that declares the `/app` folder a mountable volume.
FROM vovimayhem/app:node-for-c-ish
MAINTAINER Roberto Quintanilla <roberto.quintanilla@gmail.com>

# Define the '/app' directory as a volume, to prevent persistance of files in
# this folder:
VOLUME /app
