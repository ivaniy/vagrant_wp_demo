sudo apt-get update 
#sudo debconf-set-selection <<< 'mysql-server mysql-server/root_password password root'
#sudo debconf-set-selection <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y -q mysql-server
sudo mysqladmin create wordpress
export MYSQL_ROOT_PASS=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;)
export MYSQL_WORDPRESS_PASS=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-16};echo;)
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress_user'@'192.168.56.30' IDENTIFIED BY '"$MYSQL_WORDPRESS_PASS"';FLUSH PRIVILEGES;" | sudo mysql
echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '"$MYSQL_ROOT_PASS"';FLUSH PRIVILEGES;" | sudo mysql
#echo $MYSQL_WORDPRESS_PASS
sudo sed -i 's/bind-address		= 127.0.0.1/bind-address		= 192.168.56.20/g' /etc/mysql/mysql.conf.d/mysqld.cnf
scp -i /home/vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no vagrant@php_fpm:/var/www/wrdprs.loc/wp-config-sample.php ./wp-config.php
sed -i 's/database_name_here/wordpress/g' ./wp-config.php
sed -i 's/username_here/wordpress_user/g' ./wp-config.php
sed -i 's/password_here/'"$MYSQL_WORDPRESS_PASS"'/g' ./wp-config.php
sed -i 's/localhost/192.168.56.20/g' ./wp-config.php
scp -i /home/vagrant/.ssh/id_rsa ./wp-config.php vagrant@php_fpm:/var/www/wrdprs.loc/
sudo service mysql restart