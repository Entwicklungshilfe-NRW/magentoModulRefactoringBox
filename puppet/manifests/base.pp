node default {

    include dotdeb

    class { "apt":
        always_apt_update => true
    }

    Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/", "/usr/local/bin", "/usr/local/sbin"] }

    package { 'vim': ensure => installed }
    package { 'wget': ensure => latest }
    package { 'curl': ensure => latest }
    include git
    include composer
    include modman

    # Installs Magento
    #
    # Valid versions are:
    #
    #   magento-ce-1.6.2.0
    #   magento-ce-1.7.0.2
    #   magento-ce-1.9.1.0
    #   mageplus-master
    #   magento-mirror-1.4.2.0
    #   magento-mirror-1.5.1.0
    #   magento-mirror-1.6.2.0
    #   magento-ce-2.0.0.0-dev
    class { 'phpunit':
      phar_uri => 'https://phar.phpunit.de/phpunit-4.8.27.phar'
    }
    class { "magento":
      install_magento     => false,
      magento_version     => "magento-ce-1.9.1.0",
      install_sample_data => false
    }
}
