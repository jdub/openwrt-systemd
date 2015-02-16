# systemd for OpenWrt

An experimental, unholy union of systemd and OpenWrt.


## Requirements

- You must use eglibc as your C library, as systemd requires (e)glibc and will not work with uClibc!

- I have included some supporting OpenWrt patches for things we depend on that are not available in OpenWrt yet, including:
  - `openwrt-kernel-config.patch` adds OpenWrt kernel config options required by systemd ([originally](https://lists.openwrt.org/pipermail/openwrt-devel/2014-March/024291.html) by openwrt-systemd creator, Adam Porter)
  - `openwrt-base-files.patch` avoids some conflicts between `base-files` and `systemd`


## Getting Started

- Add the following to `feeds.conf.default`:

```
src-git systemd https://github.com/jdub/openwrt-systemd.git
```

- Run:

```
./scripts/feeds update systemd
./scripts/feeds install systemd
make menuconfig
```

- Enable "Advanced configuration options (for developers)" and navigate into that menu.

- Enable "Toolchain options" and navigate into that menu.

- Under "C Library implementation", choose "eglibc".

- At the top of the menu tree, under "Base system", you'll find "systemd" package!

- Enable "systemd-udev-hwdb" and "systemd-modules-load" for a more useful system. :-)


## Contributors

- Jeff [@jdub](https://github.com/jdub) Waugh, current maintainer
- Gabe [@thagabe](https://github.com/thagabe) Rodriguez
- Adam [@aport](https://github.com/aport) Porter, creator