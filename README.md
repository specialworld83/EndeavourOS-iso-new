These are the basic needed files and folders to build EndeavourOS system.

To get more info on how we put everything together read here:
https://github.com/endeavouros-team/EndeavourOS-archiso/wiki/EndeavourOS-ISO

[![Maintenance](https://img.shields.io/maintenance/yes/2020.svg)]()

--> This is configured to run the build process inside an actual installed EndeavourOS system.

## Add and enable EndeavourOS Repository at your system

Add calamares package repo to your /etc/pacman.conf

`[endeavouros_calamares]`\
`SigLevel = PackageRequired`\
`Server = https://github.com/endeavouros-team/mirrors/releases/download/endeavouros_calamares/`


Add the developer repo add to your /etc/pacman.conf

`[endeavouros_developer]`\
`SigLevel = PackageRequired`\
`Server = https://github.com/endeavouros-team/mirrors/releases/download/mirror3-developer/`


* Uses the same signature that normal repo and has no mirrors package to install.


`sudo pacman -Syy`

## Install necessary packages
`sudo pacman -S archiso arch-install-scripts git squashfs-tools --needed`

Clone:\
`git clone https://github.com/endeavouros-team/EndeavourOS-archiso.git`

`cd EndeavourOS-archiso`

## Run fix permissions script
`sudo ./fix_permissions.sh`

## Build
`sudo ./build.sh -v`

## The iso appears at out folder

Uses archiso from archlinux as base.

* xfce4 as live environment
* Basic tools for a livecd
* Installer
* rescue tools included:

## liveiso.rescue-tools
* grsync
* dd
* ddrescue
* dd_rescue
* testdisk
* clonezilla
* partclone
* partimage
* gftp
* hdparm
* fsarchiver
* mc
* gparted

![LiveISO Screenshot](https://raw.githubusercontent.com/endeavouros-team/artwork-images-logo/master/ISO-Shot.png "LiveISO Screenshot")
