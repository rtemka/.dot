#!/bin/bash

PROGRAM=$(basename $0)
NEW_PROXY="$1" # must be as in DSN 'http://user:password@example.com:8800'

if [ -z "$NEW_PROXY" ]; then
	echo "$PROGRAM: new proxy URL is not provided" >&2
	exit 1
fi

# GIT
git config --global --unset http.proxy
git config --global --unset https.proxy
git config --global http.proxy "$NEW_PROXY"
git config --global https.proxy "$NEW_PROXY"
git config --global http.proxyauthmethod basic

# export in .bashrc for others programs like wget.
sed -E -i "s|(^export http[s]?_proxy=).*$|\1$NEW_PROXY|g" ~/.bashrc
if [ $? -ne 0 ]; then
	echo "$PROGRAM: append proxies to ~/.bashrc"
	echo "export http_proxy=$NEW_PROXY" >> ~/.bashrc
	echo "export https_proxy=$NEW_PROXY" >> ~/.bashrc
fi

# package manager proxy
sudo sed -E -i "s|(^Acquire::http[s]?::Proxy \").*(\";$)|\1$NEW_PROXY\2|g" /etc/apt/apt.conf
# Docker deamon.json proxy
sudo sed -E -i "s|(\"http[s]?-proxy\": \").*(\")|\1$NEW_PROXY\2|g" /etc/docker/daemon.json
