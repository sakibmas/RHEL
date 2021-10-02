#!/bin/bash
. ~/.bashrc
ssep="\n-----------------------------------------------------------------------------------\n"
dsep="\n===================================================================================\n"
for rid in $(subscription-manager repos --list | grep -B3 "Enabled:   1" | grep "Repo ID:" | cut -d" " -f5)
do
 # logp=/var/log/updaterepo-$rid-$(date +%Y%m%d%H%M).log
 date
 echo -e "reposync --repoid=$rid --download_path=/var/www/html --downloadcomps --download-metadata --gpgcheck"
 echo -e "$ssep"
 reposync --repoid=$rid --download_path=/var/www/html --downloadcomps --download-metadata --gpgcheck
 echo -e "$dsep"
done
createrepo --update /var/www/html
createrepo -g /var/www/html/repodata/*comps*.xml /var/www/html
yum -y update
/usr/sbin/reboot
