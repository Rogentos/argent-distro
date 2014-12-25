#!/bin/bash

SABAYON_USER="argentmce"
. /sbin/argent-functions.sh

if argent_is_mce; then
    echo "Argent Media Center mode enabled"

    echo "[Desktop]" > /var/argentmce/.dmrc
    echo "Session=argent-mce" >> /var/argentmce/.dmrc
    chown argentmce /var/argentmce/.dmrc

    if [ -x "/usr/libexec/gdm-set-session" ]; then
        /usr/libexec/gdm-set-session argentmce argent-mce
    fi
    argent_setup_autologin

elif ! argent_is_live && ! argent_is_mce; then
    echo "Argent Media Center mode disabled"
    argent_disable_autologin
fi

exit 0
