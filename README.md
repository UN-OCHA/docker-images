# docker-images
General purpose docker images repo

## Workflow

For Makefile images, you can build an image by specifying the component, tag and
upstream version on the commandline. For most images, the upstream version is a
combination of the VERSION and EXTRAVERSION, but this may differ for some.

```
$ cd alpine-base-php-fpm/php5
$ make VERSION=2.6.28-r0 EXTRAVERSION=-201701-01 build tag

$ cd alpine-php-fpm-drupal7/php5
$ make VERSION=2.6.28-r0 EXTRAVERSION=-201701-01 UPSTREAM-2.6.28-r0-201701-01
```

A notable difference are the NewRelic images for HRINFO.
