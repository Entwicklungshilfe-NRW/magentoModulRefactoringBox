#!/bin/sh
[ -d /vagrant_data/www/media ] || (mkdir /vagrant_data/www/media; chmod 0777 /vagrant_data/www/media)
cd /vagrant_data/www/shell
php ecomdev-phpunit.php -a install
php ecomdev-phpunit.php -a magento-config --db-name magento_unit_tests --db-user root --base-url http://127.0.0.1/