mv /home/centos/nexus.vmoptions /home/nexus/nexus/bin/
mv /home/centos/nexus.service /etc/systemd/system
systemctl daemon-reload
systemctl enable nexus.service
systemctl start nexus.service
