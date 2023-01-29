#!/bin/zsh
WORK_DIR=$(pwd)
CHROOT_DIR=${WORK_DIR}/buildchroot
PKG_LIST=${WORK_DIR}/aur-packages.list
MAKEPKG_CONF=/etc/aurutils/makepkg-snipex.conf

_packages=$(cat ${PKG_LIST} | grep -E "^[^#]" | wc -l)
for ((i=1; i<=_packages; i++));
do
    echo " "
    echo $i/$_packages Building "${$(cat ${PKG_LIST} | grep -E "^[^#]" | head -$i | tail +$i)%#*}"
    aur sync --noview --chroot -D ${CHROOT_DIR} -d snipex $(echo "${$(cat ${PKG_LIST} | grep -E "^[^#]" | head -$i | tail +$i)%#*}") --makepkg-conf ${MAKEPKG_CONF} --margs --skipinteg --noconfirm
done
