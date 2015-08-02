#!/bin/bash

dest=$HOME/Desktop/zuul-flash-$(gdate -I)

set -e

if [ -e "$dest" ]; then
    echo $dest exists
    exit 1
fi

mkdir "$dest"

cp ./bin/ar71xx/openwrt-ar71xx-generic-wndr3700-squashfs* "$dest"

for d in . feeds/*; do
    if [ -e $d/.git ]; then
        (cd $d ; echo -n $(git rev-parse HEAD) ) >>"$dest"/sha
        echo "    "  $d >>"$dest"/sha
    fi
done
