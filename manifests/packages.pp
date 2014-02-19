class common::packages {

    $packages = [ 'htop', 'vim-puppet', 'puppet', 'puppet-common', 'ethtool', 'zsh', 'git', 'tmux', 'yakuake', 'sysstat', 'sur5r-keyring']

    ensure_packages($packages)

    class { 'common::packages::config':
        require => Class['common::packages'],
    }

}
