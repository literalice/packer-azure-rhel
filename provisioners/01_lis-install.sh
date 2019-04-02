#!/bin/bash -eux

mkdir lis4.2.8-2
cd lis4.2.8-2
wget https://download.microsoft.com/download/6/8/F/68FE11B8-FAA4-4F8D-8C7D-74DA7F2CFC8C/lis-rpms-4.2.8-2.tar.gz

tar xvzf lis-rpms-4.2.8-2.tar.gz
cd LISISO/RHEL76

source ../commonfunctions.sh
installbuildrpm 2

cd
rm -rf lis4.2.8-2
