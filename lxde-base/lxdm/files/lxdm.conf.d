# We always try and start X on a static VT. The various DMs normally default
# to using VT7. If you wish to use the xdm init script, then you should ensure
# that the VT checked is the same VT your DM wants to use. We do this check to
# ensure that you haven't accidentally configured something to run on the VT
# in your /etc/inittab file so that you don't get a dead keyboard.
CHECKVT=7

DISPLAYMANAGER="lxdm"
