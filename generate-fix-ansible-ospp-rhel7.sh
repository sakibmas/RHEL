#!/bin/bash
sudo yum -y install openscap-scanner scap-security-guide
FileName=ospp-$(hostname)-$(date +%F)
oscap xccdf eval --profile ospp --results $FileName.xml /usr/share/xml/scap/ssg/content/ssg-rhel7-ds.xml
oscap xccdf generate report $FileName.xml > $FileName.html
oscap xccdf generate fix --profile ospp --fix-type ansible $FileName.xml > $FileName.yml

