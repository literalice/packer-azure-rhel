#!/bin/bash -eux

# Enable waaagent at boot-up
systemctl enable chronyd
systemctl enable sshd
systemctl enable NetworkManager
systemctl enable waagent

# Configure swap in WALinuxAgent
sed -i 's/^\(ResourceDisk\.EnableSwap\)=[Nn]$/\1=y/g' /etc/waagent.conf
sed -i 's/^\(ResourceDisk\.SwapSizeMB\)=[0-9]*$/\1=2048/g' /etc/waagent.conf

# Set the cmdline
sed -i 's/^\(GRUB_CMDLINE_LINUX\)=".*"$/\1="console=tty1 console=ttyS0 earlyprintk=ttyS0 rootdelay=300"/g' /etc/default/grub

echo 'add_drivers+=" hv_vmbus hv_netvsc hv_storvsc "' >> /etc/dracut.conf
dracut --regenerate-all --force -v

#user namespace
echo 'user.max_user_namespaces = 15000' > /etc/sysctl.d/99-user-namespace.conf

# Enable SSH keepalive
sed -i 's/^#\(ClientAliveInterval\).*$/\1 180/g' /etc/ssh/sshd_config

# Build the grub cfg
grub2-mkconfig -o /boot/grub2/grub.cfg

# Configure network
cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
TYPE="Ethernet"
BOOTPROTO="dhcp"
DEFROUTE="yes"
PEERDNS="yes"
PEERROUTES="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="no"
NAME="eth0"
DEVICE="eth0"
ONBOOT="yes"
EOF

subscription-manager unregister

# Deprovision and prepare for Azure
waagent -force -deprovision

export HISTSIZE=0

