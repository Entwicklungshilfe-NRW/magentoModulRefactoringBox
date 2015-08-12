class magento(
  $install_magento     = true,
  $magento_version     = "magento-ce-1.9.1.0",
  $install_sample_data = true
) {

    host { "magento.local":
        ip => "127.0.0.1"
    }

    include magento::nginx
    include magento::mysql
    include magento::php
    include magento::php_fpm

    augeas { "php.ini":
      require => Class["php"],
      context => "/files/etc/php5/fpm/php.ini",
      changes => [
        'xdebug.profiler_enable=1',
        'xdebug.remote_enable = on',
        'xdebug.remote_connect_back = on',
        'xdebug.idekey = "vagrant"'
      ];
    }

    class { "magento::n98magerun":
      install_magento     => $install_magento,
      magento_version     => $magento_version,
      install_sample_data => $install_sample_data
      require             => Exec['install_phpunit_magento']
    }

    exec { 'install_phpunit_magento':
      command     => "cd /vagrant_data/shell && php ecomdev-phpunit.php -a install && php ecomdev-phpunit.php -a magento-config --db-name magento_unit_tests --db-user root --base-url http://127.0.0.1/",
    }
}