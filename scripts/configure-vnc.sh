#!/bin/bash 

VNC_DIR="${HOME}/.vnc"
mkdir -p ${VNC_DIR}
chmod -R 750 ${VNC_DIR}

cat > ${VNC_DIR}/xstartup <<EOF
#!/bin/sh

xrdb \$HOME/.Xresources
xsetroot -solid grey
touch "/root/.config/google-chrome/First Run"
sleep 3 && google-chrome -start-maximized --no-sandbox --user-data-dir=/root/.config/google-chrome &

export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession
EOF
chmod 755 ${VNC_DIR}/xstartup

# write vnc password
echo -en "$(echo -n 'admin' | vncpasswd -f | hexdump | head -n1 | cut -b 9- | tr -d ' ' | sed 's/\(..\)\(..\)/\\x\2\\x\1/g' | tr -d '\n')" > ${VNC_DIR}/passwd
chmod 600 ${VNC_DIR}/passwd

