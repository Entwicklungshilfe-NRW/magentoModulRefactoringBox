class magento::php {
    include php
    include phpunit
    php::module { ['xdebug', 'cgi']:
        require => Class["php::install", "php::config"]
    }
    php::conf { [ 'pdo' ]:
        source  => 'puppet:///modules/magento/etc/php5/conf.d/pdo.ini',
        require => Class["php::install", "php::config"],
    }
    php::conf { [ 'pdo_mysql' ]:
        source  => 'puppet:///modules/magento/etc/php5/conf.d/pdo_mysql.ini',
        require => [Class["php::install", "php::config"],Exec['install_phpunit_magento']]
    }

  exec { 'install_phpunit_magento':
    provider => shell,
    require => [Class['magento'],Package['php5-cli']],
    command     => "cd /vagrant_data/www/shell && php ecomdev-phpunit.php -a install && php ecomdev-phpunit.php -a magento-config --db-name magento_unit_tests --db-user root --base-url http://127.0.0.1/",
  }
}