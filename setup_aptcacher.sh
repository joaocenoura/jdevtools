#!/bin/bash
set -e

# change if necessary; check apt-cacher-ng.git Vagrantfile
APT_CACHER_IP="192.168.33.254"

# variables
BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
APT_CACHER_PROJ=$BASEDIR/tmp/apt-cacher-ng
APT_CACHER_CONF=$BASEDIR/provisioning/roles/common/vars/aptcacher.yml

if [ ! -d $APT_CACHER_PROJ ]; then
	git clone https://github.com/joaocenoura/apt-cacher-ng.git $APT_CACHER_PROJ
fi
echo "creating $APT_CACHER_CONF"
echo -e "---\naptcacher_host: ${APT_CACHER_IP}:3142" > $APT_CACHER_CONF

echo "done!"