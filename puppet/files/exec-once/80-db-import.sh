#!/bin/sh

echo "Importing SQL dump from $DUMP. This will take a while..."
echo "You can ignore warnings about using a password on the command line interface." >&2

DBH="localhost";
DBU="root"
DBP="root"
DBN="magento"
DUMP="/vagrant/systemstorage/database/magentoTestWithSampleData.sql"

echo "Import database magento"
mysql -h ${DBH} -u${DBU} -p${DBP} -e "create database if not exists ${DBN} ";
mysql -h ${DBH} -u${DBU} -p${DBP} ${DBN} < ${DUMP}

DBN="magento_unit_tests"
DUMP="/vagrant/systemstorage/database/magentoUnitTests.sql"
echo "Import database magento_unit_tests"
mysql -h ${DBH} -u${DBU} -p${DBP} -e "create database if not exists ${DBN} ";
mysql -h ${DBH} -u${DBU} -p${DBP} ${DBN} < ${DUMP}

echo "Done importing SQL dump."