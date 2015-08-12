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
      context => "/files/etc/php.ini/PHP",
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
    }
}