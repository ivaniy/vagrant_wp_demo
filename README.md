Prerequisites
-------------

[VirtualBox](https://www.virtualbox.org/)

Vagrant plugin [Hostmanager](https://github.com/devopsgroup-io/vagrant-hostmanager) 

    $ vagrant plugin install vagrant-hostmanager

Usage
-----

    $ vagrant up

It creates a three VM's on VirtualBox
```
nginx - with nginx server 
php_fpm - with PHP FastCGI Process Manager
mysql - with mysql server
```
After it's configure MySQL server and WordPress config file to connect to this server

for destroy all machines and cleanup wordpress files use

    $ vagrant destroy -f && rm -rf ~/vagrant-homework/wrdprs.loc && mkdir wrdprs.loc
