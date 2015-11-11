#!/bin/bash

URL="$1"

if [ -z "${URL}" ] ; then
	echo "Usage: docker next-swarm-slave <URL>"
	exit 1
fi

set -x

function terminateProcesses(){
	kill $( ps auxww | grep -i Xtightvnc | grep -v grep | awk '{print $2}') 2> /dev/null || true
	kill $( ps auxww | grep -i google-chrome | grep -v grep | awk '{print $2}') 2> /dev/null || true
}

function startVncServer() {
	sed -i 's$"startup_urls" : \[ "[^"]*"$"startup_urls" : \[ "'${URL}'/get-task?containerId='$(hostname)'"$'  ~/.config/google-chrome/Default/Preferences
	USER=root
	HOME=/root
	export USER HOME
	vncserver
}

function isNextSwarmServerRunning() {
	curl -sL "${URL}" -o/dev/null && return 0 || return 1
}

ifconfig -a

startVncServer

while isNextSwarmServerRunning; do
	sleep 3
	ps auxww
done

terminateProcesses

trap terminateProcesses EXIT


