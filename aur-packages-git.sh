#!/bin/zsh
WORK_DIR=$(pwd)
CHROOT_DIR=/tmp_storage/linux/buildchroot
PKG_LIST=${WORK_DIR}/aur-packages-git.list
MAKEPKG_CONF=/etc/makepkg.conf
AUR_DIR=${WORK_DIR}/AUR

_packages=$(cat ${PKG_LIST} | grep -E "^[^#]" | wc -l)
for ((i=1; i<=_packages; i++));
do
    echo " "
    echo $i/$_packages Building "$(cat ${PKG_LIST} | sed 's/#.*//' | grep . | head -$i | tail +$i)"
    AURDEST=$AUR_DIR aur sync --noview --chroot -D ${CHROOT_DIR} --rebuild -d snipex "$(cat ${PKG_LIST} | sed 's/#.*//' | grep . | head -$i | tail +$i)" --makepkg-conf ${MAKEPKG_CONF} --margs --skipinteg --noconfirm
done
