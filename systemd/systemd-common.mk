SYSTEMD_BIN = \
	busctl \
	journalctl \
	systemctl \
	systemd-analyze \
	systemd-ask-password \
	systemd-cat \
	systemd-cgls \
	systemd-cgtop \
	systemd-delta \
	systemd-detect-virt \
	systemd-machine-id-setup \
	systemd-notify \
	systemd-nspawn \
	systemd-run \
	systemd-tty-ask-password-agent

SYSTEMD_LIB = \
	systemd \
	systemd-ac-power \
	systemd-activate \
	systemd-bus-proxyd \
	systemd-cgroups-agent \
	systemd-fsck \
	systemd-initctl \
	systemd-journald \
	systemd-remount-fs \
	systemd-reply-password \
	systemd-shutdown \
	systemd-shutdownd \
	systemd-sleep \
	systemd-socket-proxyd \
	systemd-sysctl \
	systemd-update-utmp

SYSTEMD_SYSTEM_TARGET_WANTS = \
	sockets.target.wants \
	runlevel1.target.wants \
	runlevel2.target.wants \
	runlevel3.target.wants \
	runlevel4.target.wants \
	runlevel5.target.wants \
	multi-user.target.wants \
	local-fs.target.wants \
	busnames.target.wants \
	sysinit.target.wants

SYSTEMD_SYSTEM_TARGETS = \
	basic.target \
	bluetooth.target \
	busnames.target \
	emergency.target \
	final.target \
	getty.target \
	graphical.target \
	halt.target \
	initrd-fs.target \
	initrd-root-fs.target \
	initrd-switch-root.target \
	initrd.target \
	kexec.target \
	local-fs-pre.target \
	local-fs.target \
	multi-user.target \
	network-online.target \
	nss-lookup.target \
	nss-user-lookup.target \
	paths.target \
	poweroff.target \
	printer.target \
	reboot.target \
	remote-fs-pre.target \
	remote-fs.target \
	rescue.target \
	rpcbind.target \
	runlevel0.target \
	runlevel1.target \
	runlevel2.target \
	runlevel3.target \
	runlevel4.target \
	runlevel5.target \
	runlevel6.target \
	shutdown.target \
	sigpwr.target \
	sleep.target \
	slices.target \
	smartcard.target \
	sockets.target \
	sound.target \
	suspend.target \
	swap.target \
	sysinit.target \
	system-update.target \
	timers.target \
	time-sync.target \
	umount.target

SYSTEMD_SYSTEM_SOCKETS = \
	syslog.socket \
	systemd-initctl.socket \
	systemd-journald.socket \
	systemd-shutdownd.socket

SYSTEMD_SYSTEM_PATHS = \
	systemd-ask-password-console.path \
	systemd-ask-password-wall.path

SYSTEMD_SYSTEM_SERVICES = \
	autovt@.service \
	console-getty.service \
	console-shell.service \
	container-getty@.service \
	debug-shell.service \
	emergency.service \
	getty@.service \
	halt-local.service \
	initrd-cleanup.service \
	initrd-parse-etc.service \
	initrd-switch-root.service \
	quotaon.service \
	rc-local.service \
	rescue.service \
	serial-getty@.service \
	systemd-ask-password-console.service \
	systemd-ask-password-wall.service \
	systemd-fsck-root.service \
	systemd-fsck@.service \
	systemd-halt.service \
	systemd-initctl.service \
	systemd-journald.service \
	systemd-journal-flush.service \
	systemd-kexec.service \
	systemd-nspawn@.service \
	systemd-poweroff.service \
	systemd-reboot.service \
	systemd-remount-fs.service \
	systemd-shutdownd.service \
	systemd-suspend.service \
	systemd-sysctl.service \
	systemd-update-utmp-runlevel.service \
	systemd-update-utmp.service \
	user@.service

SYSTEMD_SYSTEM_MOUNTS = \
	dev-hugepages.mount \
	dev-mqueue.mount \
	sys-fs-fuse-connections.mount \
	sys-kernel-config.mount \
	sys-kernel-debug.mount \
	tmp.mount

SYSTEMD_UDEV_SYSTEM_SERVICES = \
	initrd-udevadm-cleanup-db.service \
	systemd-udevd.service \
	systemd-udev-settle.service \
	systemd-udev-trigger.service

SYSTEMD_UDEV_SYSTEM_SOCKETS = \
	systemd-udevd-control.socket \
	systemd-udevd-kernel.socket

SYSTEMD_UDEV_LIBS = \
	accelerometer \
	ata_id \
	cdrom_id \
	collect \
	mtd_probe \
	scsi_id \
	v4l_id

SYSTEMD_UDEV_RULES = \
	42-usb-hid-pm.rules \
	50-udev-default.rules \
	60-cdrom_id.rules \
	60-drm.rules \
	60-keyboard.rules \
	60-persistent-alsa.rules \
	60-persistent-input.rules \
	60-persistent-serial.rules \
	60-persistent-storage.rules \
	60-persistent-storage-tape.rules \
	60-persistent-v4l.rules \
	61-accelerometer.rules \
	64-btrfs.rules \
	75-net-description.rules \
	75-probe_mtd.rules \
	75-tty-description.rules \
	78-sound-card.rules \
	80-net-setup-link.rules \
	95-udev-late.rules \
	99-systemd.rules

SYSTEMD_UDEV_HWDB = \
	20-acpi-vendor.hwdb \
	20-bluetooth-vendor-product.hwdb \
	20-net-ifname.hwdb \
	20-OUI.hwdb \
	20-pci-classes.hwdb \
	20-pci-vendor-model.hwdb \
	20-sdio-classes.hwdb \
	20-sdio-vendor-model.hwdb \
	20-usb-classes.hwdb \
	20-usb-vendor-model.hwdb \
	60-keyboard.hwdb
