class common::packages {

    $packages = [ 'htop', 'vim-puppet', 'puppet', 'puppet-common', 'ethtool', 'zsh', 'git', 'tmux', 'yakuake', 'sysstat', ]

    ensure_packages($packages)

    class { 'common::packages::config':
        require => Class['common::packages'],
    }

}
