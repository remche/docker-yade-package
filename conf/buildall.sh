#!/bin/bash

distros=(jessie stretch unstable trusty xenial yakkety)

cd docker-yade-package
for distro in ${distros[@]}; do
    rm -rf /tmp/pkg-$distro/*
    echo "Building for $distro"
    DISTR=$distro /usr/local/bin/docker-compose -p $distro run --rm yade > /tmp/build-$distro.log
    dput -U yade-dem.org /tmp/pkg-$distro/*.changes
    rm -rf /tmp/pkg-$distro/trunk
done

docker rm -v $(docker ps -a -q -f status=exited)
