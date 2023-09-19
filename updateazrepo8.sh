#!/bin/bash
. ~/.bashrc
dsep="==================================================================================="
yum -y install createrepo yum-utils httpd
for rid in $(yum repolist | awk '/repo id/{found=1} found' | grep -v "repo id" | awk '{print $1}')
do
 date
 echo -e "reposync --repoid=$rid --download-path=/var/www/html"
 echo -e "$dsep"
 reposync --repoid=$rid --download-path=/var/www/html --downloadcomps --download-metadata --delete --gpgcheck
 echo -e "$dsep"
done
echo -e "$dsep\nCreating xml-based repo file\n$dsep"
createrepo --update --verbose /var/www/html
yum -y --releasever=8.4 --exclude=redhat-release* update
