This project has been forked from aport's openwrt-systemd
<url>https://github.com/aport/openwrt-systemd.git</url>

I will, to the best of my abilities, try to maintain the implementation of systemd on openwrt.

What is systemd?
Systemd is a suite of system management daemons, libraries, and utilities designed as a central management and configuration platform for the Linux computer operating system.
        Much like launchd for Mac OS X it tries to parellalize as many resources at boot in order to speedup boot times.

Why am I doing this?
I'm new to much of open source and free software, then again I'm also new to software in general. My goal is to, one day, mainline systemd as an optional init system for OpenWRT. I have seen the advantages of systemd in performance, manageability, and ease of use, thus I would like to incorporate systemd fuctionality to Openwrt and, for the hardware that can support it, produce real world performance gains.

State of implementation:

Aport's original iplementation was 211 since, as he described it, "This became a much simpler task with recent versions of systemd since they dropped the cyclic dependency on libdbus". However the project got very little attention and aport decided to abandon plans of maintaining it. I have forked the project and look to both mainline systemd to the openwrt trunk and to keep systemd well supported and updated! 

So far with the lastest update to trunk (specifically glib2) and updating aport's original 211 to 218 had yeilded an error somewhere near libgio is depended on libmodule.2.0. I have, as of 01-26-2015, yet to find a solution but I will dedicate time to solve this. Any help is appreciated, and if someone is more knowledgable I would be willing to transfer ownership of the project. 