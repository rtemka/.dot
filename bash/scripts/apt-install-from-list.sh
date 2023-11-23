#!/usr/bin/bash
package_list=$1
sudo apt install $(awk '{print $1'} $package_list)
