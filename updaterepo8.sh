#!/bin/bash
. ~/.bashrc
ssep="-----------------------------------------------------------------------------------"
dsep="==================================================================================="
for rid in $(subscription-manager repos --list | grep -B3 "Enabled:   1" | grep "Repo ID:" | cut -d" " -f5)
do
 date
 echo -e "reposync --repoid=$rid --download-path=/var/www/html"
 echo -e "$ssep"
 reposync --repoid=$rid --download-path=/var/www/html --downloadcomps --download-metadata
 echo -e "$ssep\nCreating xml-based group file\n$ssep"
 createrepo --verbose -g /var/www/html/$rid/repodata/repomd.xml /var/www/html/$rid/repodata
 echo -e "$dsep"
done
echo -e "$ssep\nCreating xml-based repo file\n$ssep"
createrepo --update --verbose /var/www/html
yum -y --releasever=8.4 update
/usr/sbin/reboot
