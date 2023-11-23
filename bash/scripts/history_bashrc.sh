#!/bin/bash

cat << EOF >> ~/.bashrc
# history settings
export HISTSIZE=10000
export HISTCONTROL=ignoreboth
export HISTFILESIZE=10000
EOF
