yum install -y epel-release
yum install -y nginx

pushd /home/nexus


wget --no-clobber http://download.sonatype.com/nexus/3/latest-unix.tar.gz

tar -zxvf latest-unix.tar.gz

ln -sf /home/nexus/nexus-3.2.1-01/ /home/nexus/nexus

mkdir -p /home/nexus/sonatype-work/nexus3/etc/

chown -R nexus:nexus /home/nexus

popd
#rm -rf latest-unix.tar.gz
