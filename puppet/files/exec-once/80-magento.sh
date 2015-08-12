#!/bin/bash
#
# Change these values according to your needs:
#
DOMAIN=127.0.0.1:8080
MAGENTO_VERSION=magento-ce-1.9.2.1

# always run this script as vagrant user
if [ "$USER" != "vagrant" ]; then
	sudo -u vagrant -H sh -c "sh $0"
	exit
fi


# if we can't find an agent, start one, and restart the script.
if [ -z "$SSH_AUTH_SOCK" ] ; then
  exec ssh-agent bash -c "ssh-add ~/.ssh/*_id_rsa; $0 $*"
  exit
fi


# Install dependencies from composer.
# Extensions from Composer will be deployed after Magento has been installed
# --no-scripts prevents modman deploy
cd /

# link project modman packages
modman link /.modman/*

# Use n98-magerun to set up Magento (database and local.xml)
# uses --noDownload because Magento core is deployed with composer.
# Remove the line if there already is a configured Magento installation
n98-magerun install --noDownload --dbHost="localhost" --dbUser="magento" --dbPass="root" --dbName="magento" --installSampleData=no --useDefaultConfigParams=yes --magentoVersionByName="$MAGENTO_VERSION" --installationFolder="vagrant_data" --baseUrl="http://$DOMAIN/" --forceUseDb="magento"

# Now after Magento has been installed, deploy all additional modules and run setup scripts
modman deploy-all --force
n98-magerun sys:setup:run

# Set up PHPUnit
cd /vagrant_data/shell

exit