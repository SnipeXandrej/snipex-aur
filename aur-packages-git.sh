#!/bin/zsh
PKG_LIST=./aur-packages-git.list
CHROOT_DIR=./buildchroot
MAKEPKG_CONF=/etc/aurutils/makepkg-snipex.conf

_packages=$(cat ${PKG_LIST} | grep -E "^[^#]" | wc -l)
for ((i=1; i<=_packages; i++));
do
    echo " "
    echo $i/$_packages Building "${$(cat ${PKG_LIST} | grep -E "^[^#]" | head -$i | tail +$i)%#*}"
    aur sync --noview --chroot -D ${CHROOT_DIR} --rebuild -d snipex $(echo "${$(cat ${PKG_LIST} | grep -E "^[^#]" | head -$i | tail +$i)%#*}") --makepkg-conf ${MAKEPKG_CONF} --margs --skipinteg --noconfirm
done
