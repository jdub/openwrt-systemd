# systemd for OpenWrt

An experimental, unholy union of systemd and OpenWrt.


## Requirements

- You must use eglibc as your C library, as systemd requires (e)glibc and will not work with uClibc!

- I have included some supporting OpenWrt patches for things we depend on that are not available in OpenWrt yet, including:
  - `openwrt-kernel-config.patch` adds OpenWrt kernel config options required by systemd (by @aport)
  - `openwrt-base-files.patch` avoids some conflicts between `base-files` and `systemd`


## Getting Started

- Add the following to `feeds.conf.default`:

	src-git systemd https://github.com/jdub/openwrt-systemd.git

- Run:

	./scripts/feeds update systemd
	./scripts/feeds install systemd
	make menuconfig

- Enable "Advanced configuration options (for developers)" and navigate into that menu.

- Enable "Toolchain options" and navigate into that menu.

- Under "C Library implementation", choose "eglibc".

- At the top of the menu tree, under "Base system", you'll find "systemd" package!

- Enable "systemd-udev-hwdb" and "systemd-modules-load" for a more useful system. :-)


## Contributors

- Adam @aport Porter
- Gabe @thagabe Rodriguez
- Jeff @jdub Waugh