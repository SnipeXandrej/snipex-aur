#!/bin/zsh
WORK_DIR="$(pwd)"
CHROOT_DIR="/tmp/linux/buildchroot"
MAKEPKG_CONF="/etc/makepkg.conf"
AUR_DIR="${WORK_DIR}/AUR"
PKG_LIST_PATH="${WORK_DIR}/aur-packages.list"
PKG_LIST_GIT_PATH="${WORK_DIR}/aur-packages-git.list"


if [[ $@ == *"--rebuild"* ]]
then _REBUILD="--rebuild"
else _REBUILD=""
fi

if [[ $@ == *"--git"* ]]
then _PKG_LIST=$PKG_LIST_GIT_PATH
else _PKG_LIST=$PKG_LIST_PATH
fi

i_package() {
    cat ${_PKG_LIST} | sed 's/#.*//' | grep . | head -$i | tail +$i
}

_packages=$(cat ${_PKG_LIST} | grep -E "^[^#]" | wc -l)

for ((i=1; i<=_packages; i++));
do
    echo " "
    echo $i/$_packages Building "$(i_package)"
    AURDEST=$AUR_DIR aur sync --noview --chroot -D ${CHROOT_DIR} ${_REBUILD} -d snipex $(i_package) --makepkg-conf ${MAKEPKG_CONF} --margs --skipinteg --noconfirm
done


# echo "Rebuild? $_REBUILD"
# echo "Git?     $_PKG_LIST"
