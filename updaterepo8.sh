#!/bin/bash
. ~/.bashrc
dsep="==================================================================================="
for rid in $(subscription-manager repos --list | grep -B3 "Enabled:   1" | grep "Repo ID:" | cut -d" " -f5)
do
 date
 echo -e "reposync --repoid=$rid --download-path=/var/www/html"
 echo -e "$dsep"
 reposync --repoid=$rid --download-path=/var/www/html --downloadcomps --download-metadata --delete --gpgcheck
 echo -e "$dsep\nCreating xml-based group file\n$dsep"
 createrepo --verbose -g /var/www/html/$rid/repodata/repomd.xml /var/www/html/$rid/repodata
 echo -e "$dsep"
done
echo -e "$dsep\nCreating xml-based repo file\n$dsep"
createrepo --update --verbose /var/www/html
yum -y --releasever=8.4 update
/usr/sbin/reboot
