include stdlib

class common {

    include common::sources

    class { 'common::packages':
        require => Class['common::sources'],
    }



    class { 'ohmyzsh': }
    ohmyzsh::install { 'rennecke': }



    file { '/usr/sbin/batched_discard':
        ensure => present,
        source => 'puppet:///modules/anacron/batched_discard',
        owner  => 'root',
        group  => 'root',
        mode   => '0550',
        before => Class['anacron'],
    }

    class { 'anacron':
        jobs => {
            'trim_ssd' => {
                command => '/usr/sbin/batched_discard',
                comment => 'weekly trim',
                delay   => 5,
                period  => 7,
            }
        }
    }


    class { '::ntp':
        servers => [ '0.de.pool.ntp.org', '1.de.pool.ntp.org', '2.de.pool.ntp.org', '3.de.pool.ntp.org', ],
    }
}
