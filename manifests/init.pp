include stdlib

class common {

    $packages = [ 'htop', 'vim-puppet', 'puppet', 'puppet-common', 'ethtool', 'zsh', 'git', 'tmux', 'yakuake']
    package { 'guake':
        ensure => purged,
    }
	ensure_packages($packages)

	class { 'ohmyzsh': }
	ohmyzsh::install { 'rennecke': }


    file { '/var/lib/vim/addons/syntax/':
        ensure => directory,
    }

    file { '/var/lib/vim/addons/ftdetect/':
        ensure => directory,
    }

    file { '/var/lib/vim/addons/syntax/puppet.vim':
        ensure  => link,
        target  => '/usr/share/vim/addons/syntax/puppet.vim',
        require => [Package['vim-puppet'], File['/var/lib/vim/addons/syntax/'] ],
    }

    file { '/var/lib/vim/addons/ftdetect/puppet.vim':
        ensure  => link,
        target  => '/usr/share/vim/addons/ftdetect/puppet.vim',
        require => [ Package['vim-puppet'], File['/var/lib/vim/addons/ftdetect'], ],
    }

    file { '/usr/sbin/batched_discard':
        ensure => present,
        source => 'puppet:///modules/anacron/batched_discard',
        owner  => 'root',
        group  => 'root',
        mode   => '550',
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

    class { 'apt':
        update_timeout => 300,
		always_apt_update => true,
    }

    apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main dependencies',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
        pin        => 1000,
    }


	case $::operatingsystem {
    	debian: { 
			$repo = "main" 
		}
      	ubuntu: { 
			$repo = "universe"
		}
      	default: {
			fail("Unrecognized operating system for i3 rpo")
		}
    }

	apt::source { 'i3-stable':
		location => 'http://debian.sur5r.net/i3',
		repos    => $repo,
		key      => '6298B4A2',
		pin      => 1001,
	}


	class { '::ntp':
 		servers => [ '0.de.pool.ntp.org', '1.de.pool.ntp.org', '2.de.pool.ntp.org', '3.de.pool.ntp.org', ],
	}
}
