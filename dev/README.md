# Docker App Containers for App Development

Heavily inspired by the official Docker images for ruby, jruby, etc., this
project seeks to generate containers that help you run your app in a development
environment.

It is based on the `vovimayhem/app` images, but with rubies compiled with DTrace.

## Available Tags

  - Latest "standard" MRI ruby: `ruby`, `mri`, `mri-2`, `mri-2.2`, `mri-2.2.2`
    - MRI 2.1.x series: `mri-2.1`, `mri-2.1.6`
    - MRI 2.0.x series: `mri-2.0`, `mri-2.0.0-p645`
  - Latest JRuby: `jruby`, `jruby-9k`, `jruby-9k-pre2`
    - `jruby-1.7`
  - Latest Rubinius: `rbx`, `rbx-2`, `rbx-2.5`, `rbx-2.5.3`
    - `rbx-2`
  - `base-ruby` & `base-jruby`, both contain only development dependencies for
  the rest of the available images.

## Source Repository
Be sure to check it @ [Github vovimayhem/docker-app-containers](https://github.com/vovimayhem/docker-app-containers),
under the [`dev`](https://github.com/vovimayhem/docker-app-containers/tree/master/dev) directory.
