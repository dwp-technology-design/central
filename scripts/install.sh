su - nexus

cd ~/
wget --no-clobber http://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -zxvf latest-unix.tar.gz
ln -sf /home/nexus/nexus-3.2.1-01/ /home/nexus/nexus
#rm -rf latest-unix.tar.gz
