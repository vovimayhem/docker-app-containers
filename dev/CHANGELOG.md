# Change log

## 2015-09-23
- Changed `$GEM_HOME` path out of the `/app` volume, as some gems were failing
  to build when creating symlinks on VirtualBox Docker hosts with a common use case of
  mounting the app code from Host.
