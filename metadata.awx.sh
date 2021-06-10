#!/bin/bash

PACKAGES=""
PACKAGES+=" ansible"
PACKAGES+=" ansible-python3"
PACKAGES+=" docker-cli"
PACKAGES+=" docker-engine"
PACKAGES+=" docker-compose"
PACKAGES+=" firewalld"
PACKAGES+=" git"
PACKAGES+=" libselinux-python3"
PACKAGES+=" python3"
PACKAGES+=" python3-pip"
PACKAGES+=" python3-setuptools"
PACKAGES+=" yum-cron"
yum -y install ${PACKAGES}

sed -i -r -e 's/\s+no$/ yes/g' /etc/yum/yum-cron*.conf
sed -i -r -e '/^autoinstall/s/no/yes/' /etc/uptrack/uptrack.conf

systemctl enable --now dbus.service
systemctl enable --now docker.service
systemctl enable --now firewalld.service
systemctl enable --now yum-cron.service

uptrack-upgrade -y --all

for service in http https
do
  # XXX Prevent terraform from prasing service variable by not using curly brace
  firewall-offline-cmd --zone=public --add-service=$service
done

systemctl restart firewalld.service

if [ ! -d ${GIT_CHECKOUT} ]
then
  git clone ${GIT_REPO} ${GIT_CHECKOUT}
fi
cd ${GIT_CHECKOUT}
git pull
git checkout tags/${GIT_TAG}

cd ${GIT_CHECKOUT}/installer
ansible-playbook-3 install.yml -i inventory -e @/root/awx.vars.yml

chmod +x /etc/cron.daily/docker-compose-pull

/etc/cron.daily/docker-compose-pull

