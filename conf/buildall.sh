#!/bin/bash

distros=(jessie stretch unstable trusty xenial yakkety)

cd docker-yade-package
for distro in ${distros[@]}; do
    echo "Building for $distro"
    DISTR=$distro /usr/local/bin/docker-compose -p $distro up > /tmp/build-$distro.log
    dput -U yade-dem.org /tmp/pkg-$distro/*.changes
    rm -rf /tmp/pkg-$distro/*
done

docker rm -v $(docker ps -a -q -f status=exited)


