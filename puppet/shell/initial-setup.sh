#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

VAGRANT_CORE_FOLDER=$(echo "$1")

OS=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" ID)
CODENAME=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" CODENAME)
RELEASE=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" RELEASE)

if [[ ! -d '/.puphpet-stuff' ]]; then
    mkdir '/.puphpet-stuff'
    echo 'Created directory /.puphpet-stuff'
fi

touch '/.puphpet-stuff/vagrant-core-folder.txt'
echo "${VAGRANT_CORE_FOLDER}" > '/.puphpet-stuff/vagrant-core-folder.txt'

# Adding this here with a datestamped filename for future issues like #1189
# apt repos become stale, Ubuntu/Debian move stuff around and break existing
# boxes that no longer require apt-get update. Force it one more time. Update
# datestamp as required for future breaks.
if [[ ! -f '/.puphpet-stuff/initial-setup-apt-get-update' ]]; then
        echo 'Running initial-setup apt-get update'
        apt-get update >/dev/null
        echo 'Finished running initial-setup apt-get update'
        echo 'Running initial-setup apt-get upgrade'
        apt-get -q -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade > /dev/null
        echo 'Finished running initial-setup apt-get upgrade'
        echo 'Running initial-setup apt-get dist-upgrade'
        apt-get -q -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" dist-upgrade > /dev/null
        echo 'Finished running initial-setup apt-get dist-upgrade'
    touch '/.puphpet-stuff/initial-setup-repo-update'
fi

if [[ -f '/.puphpet-stuff/initial-setup-base-packages' ]]; then
    exit 0
fi

echo 'Installing curl'
apt-get -y install curl >/dev/null
echo 'Finished installing curl'

echo 'Installing mysql-server'
apt-get -y install mysql-server >/dev/null
mysqladmin -u root password root
mysqladmin -u root -proot create magento_unit_tests
mysqladmin -u root -proot create magento
echo 'Finished installing mysql-server'

echo 'Installing php5'
apt-get -y install php5-cli php5-mysql libt1-5 php5-cgi php5-common php5-fpm php5-gd php5-mcrypt php5-curl php5-xdebug
echo 'Finished installing php5'

echo 'Installing git'
apt-get -y install git-core >/dev/null
echo 'Finished installing git'

if [[ "${CODENAME}" == 'lucid' || "${CODENAME}" == 'precise' ]]; then
    echo 'Installing basic curl packages'
    apt-get -y install libcurl3 libcurl4-gnutls-dev curl >/dev/null
    echo 'Finished installing basic curl packages'
fi

echo 'Installing build-essential packages'
apt-get -y install build-essential >/dev/null
echo 'Finished installing build-essential packages'

touch '/.puphpet-stuff/initial-setup-base-packages'
