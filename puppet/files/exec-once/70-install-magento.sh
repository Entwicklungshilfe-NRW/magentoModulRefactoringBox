#!/bin/sh
#
# This script uses n98-magerun to install a fresh Magento in the repository if it is not already there
#
#DOMAIN=`cat /vagrant/etc/domain`
#MAGENTO_VERSION=magento-ce-1.9.2.1
#INSTALL_DIR=/vagrant/`cat /vagrant/etc/src`

#if [ ! -f "$INSTALL_DIR/app/Mage.php" ]; then
#	n98-magerun install --dbHost="localhost" --dbUser="magento" --dbPass="root" --dbName="magento" --installSampleData=no --useDefaultConfigParams=yes --magentoVersionByName="$MAGENTO_VERSION" --installationFolder="$INSTALL_DIR" --baseUrl="http://$DOMAIN/"
#fi

[ -d /vagrant_data/media ] || (mkdir /vagrant_data/media; chmod 0777 /vagrant_data/media)