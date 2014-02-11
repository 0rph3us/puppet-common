class common::install_mongo {
    
    class {'::mongodb::globals':
        manage_package_repo => true,
    }

    class {'::mongodb::server':
        port    => 27018,
        bind_ip => ['127.0.0.1'],
        verbose => true,
        require => Class['::mongodb::globals'],
    }
}
