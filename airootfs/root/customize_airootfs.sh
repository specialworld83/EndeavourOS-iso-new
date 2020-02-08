#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/bash root
cp -aT /etc/skel/ /root/
chmod 700 /root

! id liveuser && useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash liveuser
#injecting Desktop settings for LiveUser:
git clone https://github.com/endeavouros-team/liveuser-desktop-settings.git
cd liveuser-desktop-settings
rm -R /home/liveuser/.config
cp -R .config /home/liveuser/
chown -R liveuser:users /home/liveuser/.config
#cp install /home/liveuser/
#chmod +x /home/liveuser/install
#chown liveuser:users /home/liveuser/install
#cp preinfo.txt /home/liveuser/
#chown liveuser:users /home/liveuser/preinfo.txt
cd .. 
rm -R liveuser-desktop-settings
#
chmod 755 /etc/sudoers.d
mkdir -p /media
chmod 755 /media
chmod 440 /etc/sudoers.d/g_wheel
#chmod 644 /etc/systemd/system/*.service
chown 0 /etc/sudoers.d
chown 0 /etc/sudoers.d/g_wheel
chown root:root /etc/sudoers.d
chown root:root /etc/sudoers.d/g_wheel
chmod 755 /etc

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl enable NetworkManager.service vboxservice.service vmtoolsd.service vmware-vmblock-fuse.service livecd.service
systemctl set-default multi-user.target

