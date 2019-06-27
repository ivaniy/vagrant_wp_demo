echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx"     | sudo tee /etc/apt/sources.list.d/nginx.list
curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -
sudo apt-get update
sudo apt-get install nginx -y
sudo service nginx enable
sudo cp /home/vagrant/wrdprs.conf /etc/nginx/conf.d/
sudo service nginx restart