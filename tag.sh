#!/bin/bash

if date --version 2>&1 | grep -q GNU ; then
    dest=$HOME/Desktop/loki-flash-$(date -I)
else
    dest=$HOME/Desktop/loki-flash-$(gdate -I)
fi

set -e

if [ -e "$dest" ]; then
    echo $dest exists
    exit 1
fi

mkdir "$dest"

cp ./bin/mvebu/openwrt-mvebu-armada-xp-linksys-mamba-squashfs-* "$dest"

for d in . feeds/*; do
    if [ -e $d/.git ]; then
        (cd $d ; echo -n $(git rev-parse HEAD) ) >>"$dest"/sha
        echo "    "  $d >>"$dest"/sha
    fi
done
