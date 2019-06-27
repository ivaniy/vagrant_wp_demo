sudo apt-get update
sudo apt-get -y install php-fpm php-mysql
sudo sed -i 's+listen = /run/php/php7.2-fpm.sock+listen = 192.168.56.30:9000+g' /etc/php/7.2/fpm/pool.d/www.conf 
sudo sed -i 's/;listen.allowed_clients =/listen.allowed_clients = 192.168.56.10,/g' /etc/php/7.2/fpm/pool.d/www.conf
sudo git clone https://github.com/WordPress/WordPress.git /var/www/wrdprs.loc
sudo service php7.2-fpm restart