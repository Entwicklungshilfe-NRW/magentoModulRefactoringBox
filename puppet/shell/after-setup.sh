#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

echo 'Installing php5'
apt-get -y install php5-cli php5-mysql libt1-5 php5-cgi php5-common php5-fpm php5-gd php5-mcrypt php5-curl php5-xdebug
echo 'Finished installing php5'

cd /vagrant_data/www
n98-magerun admin:user:change-password admin password123