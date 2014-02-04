class common::packages {

    $packages = [ 'htop', 'vim-puppet', 'puppet', 'puppet-common', 'ethtool', 'zsh', 'git', 'tmux', 'yakuake', 'nodejs', ]

    ensure_packages($packages)

    class { 'common::packages::config':
        require => Class['common::packages'],
    }

}
