#
# Copyright (C) 2006-2103 OpenWrt.org
# Copyright (C) 2014 Adam Porter
# Copyright (C) 2015 Gabe Rodriguez, Jeff Waugh
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=systemd
PKG_VERSION:=219
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=http://www.freedesktop.org/software/systemd/
PKG_MD5SUM:=e0d6c9a4b4f69f66932d2230298c9a34

PKG_BUILD_DEPENDS:=intltool/host gperf/host

include systemd-common.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/version.mk

PKG_INSTALL:=1

SYSTEMD_DISABLE_PKG = $(if $(CONFIG_PACKAGE_systemd-$(1)),,--disable-$(2))

CONFIGURE_ARGS_FAST_BUILD = \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-manpages \
	--disable-tests \
	--without-python

CONFIGURE_ARGS_EMBEDDED = \
	--disable-efi \
	--disable-firstboot \
	--disable-hibernate \
	--disable-importd \
	--disable-microhttpd \
	--disable-nls \
	--disable-pam \
	--disable-qrencode \
	--disable-sysusers \
	--enable-compat-libs

CONFIGURE_ARGS += \
	--prefix=/usr \
	--sysconfdir=/etc \
	$(CONFIGURE_ARGS_FAST_BUILD) \
	$(CONFIGURE_ARGS_EMBEDDED) \
	--disable-apparmor \
	--disable-introspection \
	--disable-gudev \
	--disable-chkconfig \
	--disable-ima \
	--disable-selinux \
	--disable-seccomp \
	--disable-audit \
	--disable-smack \
	--disable-xz \
	--disable-acl \
	--disable-gcrypt \
	--disable-libcryptsetup \
	--disable-polkit \
	--disable-elfutils \
	--disable-gnutls \
	--disable-libcurl \
	--disable-resolved \
	--disable-timesyncd \
	$(if $(CONFIG_SYSTEMD_ENABLE_KDBUS),--enable-kdbus) \
	$(if $(CONFIG_SYSTEMD_ENABLE_MYHOSTNAME),,--disable-myhostname) \
	$(call SYSTEMD_DISABLE_PKG,backlight,backlight) \
	$(call SYSTEMD_DISABLE_PKG,binfmt,binfmt) \
	$(call SYSTEMD_DISABLE_PKG,bootchart,bootchart) \
	$(call SYSTEMD_DISABLE_PKG,coredump,coredump) \
	$(call SYSTEMD_DISABLE_PKG,hostnamed,hostnamed) \
	$(call SYSTEMD_DISABLE_PKG,logind,logind) \
	$(call SYSTEMD_DISABLE_PKG,localed,localed) \
	$(call SYSTEMD_DISABLE_PKG,machined,machined) \
	$(call SYSTEMD_DISABLE_PKG,modules-load,kmod) \
	$(call SYSTEMD_DISABLE_PKG,networkd,networkd) \
	$(call SYSTEMD_DISABLE_PKG,quotacheck,quotacheck) \
	$(call SYSTEMD_DISABLE_PKG,random-seed,randomseed) \
	$(call SYSTEMD_DISABLE_PKG,rfkill,rfkill) \
	$(call SYSTEMD_DISABLE_PKG,timedated,timedated) \
	$(call SYSTEMD_DISABLE_PKG,tmpfiles,tmpfiles) \
	$(call SYSTEMD_DISABLE_PKG,vconsole-setup,vconsole)

TARGET_CFLAGS += --std=gnu99

define Package/systemd/Default
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=System and Service Manager
  URL:=http://www.freedesktop.org/wiki/Software/systemd/
  MAINTAINER:=Jeff Waugh <jdub@bethesignal.org>
endef

define Package/systemd/description/Default
  systemd is a system and service manager for Linux,
  which provides aggressive parallelization capabilities
  and socket/D-Bus activation for starting services.
endef

define Package/systemd
$(call Package/systemd/Default)
  TITLE+= (daemon)
  DEPENDS:=+@KERNEL_CGROUPS +@KERNEL_DEVTMPFS +@KERNEL_FHANDLE +@BUSYBOX_DEFAULT_SULOGIN +libcap +agetty +libmount +PACKAGE_systemd-modules-load:libkmod +libiptc +dbus @USE_EGLIBC
  MENU:=1
endef

define Package/systemd/description
$(call Package/systemd/description/Default)
  This package contains the systemd collection
  of tools.
endef

define Package/systemd/config
  source "$(SOURCE)/Config-systemd.in"
endef

define Package/systemd/conffiles
/etc/hostname
/etc/machine-id
/etc/systemd/system.conf
/etc/systemd/user.conf
endef

define Package/systemd-udev-hwdb
$(call Package/systemd/Default)
  TITLE+= (udev hwdb)
  DEPENDS:=+systemd-udevd
endef

define Package/systemd-udev-hwdb/description
$(call Package/systemd/description/Default)
  This package contains the udev hardware database files.
endef

define SystemdBuildLib
  define Package/systemd-$(1)
    $(call Package/systemd/Default)
    TITLE+= $(2)
    DEPENDS+= systemd $(3)
  endef

  define Package/systemd-$(1)/description
    $(call Package/systemd/description/Default)
    .
    This package contains the systemd $(2).
  endef

  define Package/systemd-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib/systemd
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/systemd-$(1) \
		$$(1)/usr/lib/systemd
	$(call Plugin/$(1)/install,$$(1))
  endef

  $$(eval $$(call BuildPackage,systemd-$(1)))
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libudev.so* $(1)/usr/lib
#	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgudev-1.0.so* $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsystemd.so* $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libsystemd-*.so* $(1)/usr/lib

	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include

	$(INSTALL_DIR) $(1)/usr/share/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/share/pkgconfig/*.pc $(1)/usr/share/pkgconfig
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/*.pc $(1)/usr/lib/pkgconfig
endef

define Package/systemd/install
	$(INSTALL_DIR) $(1)/etc/systemd
	$(CP) \
		$(PKG_INSTALL_DIR)/etc/systemd/{journald,system,user}.conf \
		$(1)/etc/systemd

	$(INSTALL_DIR) $(1)/etc/systemd/system/multi-user.target.wants
	ln -sf \
		/usr/lib/systemd/system/remote-fs.target \
		$(1)/etc/systemd/system/multi-user.target.wants/.

	$(INSTALL_DIR) $(1)/etc/systemd/network
	$(INSTALL_DIR) $(1)/etc/systemd/user
	$(INSTALL_DIR) $(1)/etc/network
	$(INSTALL_DIR) $(1)/etc/sysctl.d
	$(INSTALL_DIR) $(1)/etc/profile.d

	$(INSTALL_DIR) $(1)/etc/dbus-1/system.d
	$(CP) \
		$(PKG_INSTALL_DIR)/etc/dbus-1/system.d/org.freedesktop.systemd1.conf \
		$(1)/etc/dbus-1/system.d

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(addprefix $(PKG_INSTALL_DIR)/usr/bin/, \
			$(SYSTEMD_BIN)) \
		$(1)/usr/bin

	ln -sf \
		/usr/lib/systemd/systemd-bus-proxyd \
		$(1)/usr/bin/systemd-stdio-bridge

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libsystemd.so* \
		$(PKG_INSTALL_DIR)/usr/lib/libsystemd-*.so* \
		$(1)/usr/lib

	$(INSTALL_DIR) $(1)/usr/lib/sysctl.d
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/sysctl.d/50-default.conf \
		$(1)/usr/lib/sysctl.d

	$(INSTALL_DIR) $(1)/usr/lib/systemd
	$(INSTALL_BIN) \
		$(addprefix $(PKG_INSTALL_DIR)/usr/lib/systemd/, \
			$(SYSTEMD_LIB)) \
		$(1)/usr/lib/systemd

	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(addprefix $(PKG_INSTALL_DIR)/usr/lib/systemd/system/, \
			$(SYSTEMD_SYSTEM_TARGET_WANTS) \
			$(SYSTEMD_SYSTEM_TARGETS) \
			$(SYSTEMD_SYSTEM_SOCKETS) \
			$(SYSTEMD_SYSTEM_PATHS) \
			$(SYSTEMD_SYSTEM_SERVICES) \
			$(SYSTEMD_SYSTEM_MOUNTS)) \
		$(1)/usr/lib/systemd/system

	$(INSTALL_DIR) $(1)/usr/lib/systemd/system-shutdown
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system-sleep
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system-generators

	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system-generators/systemd-* \
		$(1)/usr/lib/systemd/system-generators

	$(INSTALL_DIR) $(1)/usr/lib/systemd/catalog
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/catalog/systemd.catalog \
		$(1)/usr/lib/systemd/catalog

	$(INSTALL_DIR) $(1)/usr/lib/systemd/user
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/user/* \
		$(1)/usr/lib/systemd/user

	$(INSTALL_DIR) $(1)/usr/share/dbus-1/services
	$(INSTALL_DIR) $(1)/usr/share/dbus-1/system-services
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/dbus-1/system-services/org.freedesktop.systemd1.service \
		$(1)/usr/share/dbus-1/system-services
	ln -sf \
		/usr/share/dbus-1/system-services/org.freedesktop.systemd1.service \
		$(1)/usr/share/dbus-1/services/.

	$(INSTALL_DIR) $(1)/var/log/journal
	$(INSTALL_DIR) $(1)/etc/systemd/system/getty.target.wants

	ln -sf \
		/usr/lib/systemd/system/multi-user.target \
		$(1)/etc/systemd/system/default.target

	$(INSTALL_DIR) $(1)/sbin
	ln -sf \
		/usr/lib/systemd/systemd \
		$(1)/sbin/init

	$(CP) ./files/* $(1)/
	$(VERSION_SED) $(1)/etc/os-release

	$(INSTALL_DIR) $(1)/run
	ln -sf /run $(1)/var/run
endef

define Package/systemd-udev-hwdb/install
	$(INSTALL_DIR) $(1)/etc/udev/hwdb.d

	$(INSTALL_DIR) $(1)/usr/lib/udev/hwdb.d
	$(INSTALL_DATA) \
		$(addprefix $(PKG_INSTALL_DIR)/usr/lib/udev/hwdb.d/, \
			$(SYSTEMD_UDEV_HWDB)) \
		$(1)/usr/lib/udev/hwdb.d
endef

define Plugin/tmpfiles/install
	$(INSTALL_DIR) $(1)/etc/tmpfiles.d
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-tmpfiles-* \
		$(1)/usr/lib/systemd/system
	
	$(INSTALL_DIR) $(1)/usr/lib/tmpfiles.d
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/tmpfiles.d/*.conf \
		$(1)/usr/lib/tmpfiles.d
endef

define Plugin/backlight/install
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-backlight@.service \
		$(1)/usr/lib/systemd/system
endef

define Plugin/bootchart/install
	$(INSTALL_DIR) $(1)/etc/systemd
	$(CP) \
		$(PKG_INSTALL_DIR)/etc/systemd/bootchart.conf \
		$(1)/etc/systemd
endef

define Plugin/coredump/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/systemd-coredumpctl \
		$(1)/usr/bin

	$(INSTALL_DIR) $(1)/usr/lib/sysctl.d
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/sysctl.d/50-coredump.conf \
		$(1)/usr/lib/sysctl.d
endef

define Plugin/hostnamed/install
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-hostnamed.service \
		$(1)/usr/lib/systemd/system
endef

define Plugin/localed/install
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-localed.service \
		$(1)/usr/lib/systemd/system
endef

define Plugin/machined/install
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-machined.service \
		$(1)/usr/lib/systemd/system
endef

define Plugin/modules-load/install
	$(INSTALL_DIR) $(1)/etc/modules-load.d
	$(INSTALL_DIR) $(1)/usr/lib/modules-load.d

	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-modules-load.service \
		$(1)/usr/lib/systemd/system
	
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system/sysinit.target.wants
	ln -sf \
		/usr/lib/systemd/system/systemd-modules-load.service \
		$(1)/usr/lib/systemd/system/sysinit.target.wants/.
endef

define Plugin/networkd/install
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-networkd.service \
		$(1)/usr/lib/systemd/system

	$(INSTALL_DIR) $(1)/usr/lib/systemd/network
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/network/* \
		$(1)/usr/lib/systemd/network
endef

define Plugin/quotacheck/install
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-quotacheck.service \
		$(1)/usr/lib/systemd/system
endef

define Plugin/random-seed/install
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-random-seed.service \
		$(1)/usr/lib/systemd/system

	$(INSTALL_DIR) $(1)/usr/lib/systemd/system/sysinit.target.wants
	ln -sf \
		/usr/lib/systemd/system/systemd-random-seed.service \
		$(1)/usr/lib/systemd/system/sysinit.target.wants/.
endef

define Plugin/rfkill/install
	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/systemd/system/systemd-rfkill@.service \
		$(1)/usr/lib/systemd/system
endef

define Plugin/timedated/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/timedatectl \
		$(1)/usr/bin

	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(addprefix $(PKG_INSTALL_DIR)/usr/lib/systemd/system/, \
			dbus-org.freedesktop.timedate1.service \
			org.freedesktop.timedate1.busname \
			systemd-timedated.service) \
		$(1)/usr/lib/systemd/system

	$(INSTALL_DIR) $(1)/etc/dbus-1/system.d
	$(CP) \
		$(PKG_INSTALL_DIR)/etc/dbus-1/system.d/org.freedesktop.timedate1.conf \
		$(1)/etc/dbus-1/system.d

	$(INSTALL_DIR) $(1)/usr/share/dbus-1/system-services
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/dbus-1/system-services/org.freedesktop.timedate1.service \
		$(1)/usr/share/dbus-1/system-services

	$(INSTALL_DIR) $(1)/usr/lib/systemd/system/busnames.target.wants
	ln -sf \
		/usr/lib/systemd/system/org.freedesktop.timedate1.busname \
		$(1)/usr/lib/systemd/system/busnames.target.wants/.
endef

define Package/systemd-udevd/conffiles
/etc/udev/udev.conf
endef

define Plugin/udevd/install
	$(INSTALL_DIR) $(1)/etc/udev/rules.d
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/etc/udev/udev.conf $(1)/etc/udev

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libudev.so* $(1)/usr/lib
#	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libgudev-1.0.so* $(1)/usr/lib

	$(INSTALL_DIR) $(1)/usr/lib/systemd/system
	$(CP) \
		$(addprefix $(PKG_INSTALL_DIR)/usr/lib/systemd/system/, \
			$(SYSTEMD_UDEV_SYSTEM_SERVICES) \
			$(SYSTEMD_UDEV_SYSTEM_SOCKETS)) \
		$(1)/usr/lib/systemd/system

	$(INSTALL_DIR) $(1)/usr/lib/udev
	$(INSTALL_BIN) \
		$(addprefix $(PKG_INSTALL_DIR)/usr/lib/udev/, \
			$(SYSTEMD_UDEV_LIBS)) \
		$(1)/usr/lib/udev

	$(INSTALL_DIR) $(1)/usr/lib/udev/rules.d
	$(INSTALL_DATA) \
		$(addprefix $(PKG_INSTALL_DIR)/usr/lib/udev/rules.d/, \
			$(SYSTEMD_UDEV_RULES)) \
		$(1)/usr/lib/udev/rules.d

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/udevadm \
		$(1)/usr/bin
endef

define Plugin/vconsole-setup/install
endef

$(eval $(call SystemdBuildLib,backlight,backlight tools,))
$(eval $(call SystemdBuildLib,binfmt,binfmt tool,))
$(eval $(call SystemdBuildLib,bootchart,bootchart tool,))
$(eval $(call SystemdBuildLib,coredump,coredump hook,))
$(eval $(call SystemdBuildLib,hostnamed,hostname daemon,))
$(eval $(call SystemdBuildLib,localed,locale daemon,))
$(eval $(call SystemdBuildLib,logind,login daemon,))
$(eval $(call SystemdBuildLib,machined,machine daemon,))
$(eval $(call SystemdBuildLib,modules-load,module loader,+libkmod))
$(eval $(call SystemdBuildLib,networkd,network daemon,))
$(eval $(call SystemdBuildLib,quotacheck,quotacheck tools,))
$(eval $(call SystemdBuildLib,random-seed,randomseed tools,))
$(eval $(call SystemdBuildLib,rfkill,rfkill tools,))
$(eval $(call SystemdBuildLib,timedated,timedate daemon,))
$(eval $(call SystemdBuildBin,tmpfiles,tmpfiles support,))
$(eval $(call SystemdBuildLib,udevd,device manager,))
$(eval $(call SystemdBuildLib,vconsole-setup,vconsole tool,))

$(eval $(call BuildPackage,systemd))
$(eval $(call BuildPackage,systemd-udev-hwdb))
