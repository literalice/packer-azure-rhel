#!/bin/bash -eux

# install packages
subscription-manager repos --enable=rhel-7-server-extras-rpms

yum install -y WALinuxAgent wget mdadm cryptsetup samba-client samba-common iscsi-initiator-utils

yum update -y

systemctl stop sshd
reboot