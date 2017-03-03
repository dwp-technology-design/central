adduser -m -r -U nexus

#yum -y update
yum install -y wget

cd ~
wget --no-clobber --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm"

yum localinstall -y jdk-8u60-linux-x64.rpm

