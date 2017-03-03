echo "WE ARE HERE $(pwd)"


mv /home/centos/nexus.vmoptions /home/nexus/nexus/bin/
mv /home/centos/nexus.service /etc/systemd/system
mv /home/centos/nexus.properties /home/nexus/sonatype-work/nexus3/etc/nexus.properties
mv /home/centos/nexus.conf /etc/nginx/conf.d/nexus.conf

sudo chown nginx:nginx /etc/nginx/conf.d/nexus.conf

sudo semanage port -a -t http_port_t -p tcp 8081
sudo semanage port -m -t http_port_t -p tcp 8081
sudo setsebool -P httpd_can_network_connect true

#sudo chcon -u system_u -r system_r -t httpd_sys_content_t /etc/nginx/conf.d/nexus.conf
sudo chcon -t httpd_sys_content_t /etc/nginx/conf.d/nexus.conf
#sudo semanage fcontext -a -t httpd_sys_content_t "/etc/nginx(/.*)?"
#sudo restorecon -r -v /etc/nginx

sudo systemctl daemon-reload

sudo systemctl enable nginx
sudo systemctl restart nginx

sudo systemctl enable nexus.service
sudo systemctl restart nexus.service
