#!/bin/bash

# Made by Fernando "maroto"
# Run anything in the filesystem right before being "mksquashed"

script_path=$(readlink -f ${0%/*})
work_dir=work

# Adapted from AIS. An excellent bit of code!
arch_chroot(){
    arch-chroot $script_path/${work_dir}/airootfs /bin/bash -c "${1}"
}  

do_merge(){

arch_chroot "pacman-key --init
pacman-key --add /usr/share/pacman/keyrings/endeavouros.gpg && sudo pacman-key --lsign-key 497AF50C92AD2384C56E1ACA003DB8B0CB23504F
pacman-key --populate
pacman-key --refresh-keys
pacman -Syy
sed -i 's?GRUB_DISTRIBUTOR=.*?GRUB_DISTRIBUTOR=\"EndeavourOS\"?' /etc/default/grub
sed -i 's?\#GRUB_THEME=.*?GRUB_THEME=\/boot\/grub\/themes\/EndeavourOS\/theme.txt?g' /etc/default/grub
echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
wget https://github.com/endeavouros-team/install-scripts/raw/master/cleaner_script.sh
wget https://github.com/endeavouros-team/install-scripts/raw/master/chrooted_cleaner_script.sh
wget https://github.com/endeavouros-team/install-scripts/raw/master/calamares_switcher
wget https://github.com/endeavouros-team/install-scripts/raw/master/pacstrap_calamares
wget https://raw.githubusercontent.com/endeavouros-team/install-scripts/master/update-mirrorlist
wget https://github.com/endeavouros-team/install-scripts/raw/master/calamares_for_testers
chmod +x cleaner_script.sh chrooted_cleaner_script.sh calamares_switcher pacstrap_calamares update-mirrorlist calamares_for_testers
mv cleaner_script.sh chrooted_cleaner_script.sh calamares_switcher update-mirrorlist pacstrap_calamares calamares_for_testers /usr/bin/
wget https://raw.githubusercontent.com/endeavouros-team/liveuser-desktop-settings/master/dconf/mousepad.dconf
dbus-launch dconf load / < mousepad.dconf
sudo -H -u liveuser bash -c 'dbus-launch dconf load / < mousepad.dconf'
rm mousepad.dconf
chmod -R 700 /root
chown root:root -R /root
chown root:root -R /etc/skel
chmod 644 /usr/share/endeavouros/*.png
rm -rf /usr/share/backgrounds/xfce/xfce-stripes.png
ln -s /usr/share/endeavouros/backgrounds/endeavouros-wallpaper.png /usr/share/backgrounds/xfce/xfce-stripes.png
ln -s /usr/lib/libpython3.8.so.1.0 /usr/lib/libpython3.7m.so.1.0
ln -sf /usr/lib/libboost_python38.so.1.72.0 /usr/lib/libboost_python37.so.1.69.0
chsh -s /bin/bash"
}

#################################
########## STARTS HERE ##########
#################################

do_merge
