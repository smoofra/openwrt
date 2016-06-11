#!/bin/bash

./scripts/feeds install \
	luci tmux ubi-utils dmx_usb_module bind avahi expat libdaemon \
	gdbm intltool dbus luci-ssl luci-app-ddns ddns-scripts \
	luci-app-openvpn socat bash postfix avahi-autoip minicom
