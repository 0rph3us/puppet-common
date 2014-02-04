class common::packages::config {

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
}
