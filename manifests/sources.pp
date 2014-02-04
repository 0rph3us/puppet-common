class common::sources {

    class { 'apt':
        update_timeout => 300,
    }

    apt::source { 'puppetlabs':
        location   => 'http://apt.puppetlabs.com',
        repos      => 'main dependencies',
        key        => '4BD6EC30',
        key_server => 'pgp.mit.edu',
        pin        => 1000,
    }

    # sources for node.js
    case $::operatingsystem {
		debian: {
			apt::source { "${::lsbdistcodename}-backports":
				release    => "${::lsbdistcodename}-backports",
	        	location   => 'http://ftp2.de.debian.org/debian/',
		        repos      => 'main contrib non-free',
		        pin        => 1000,
    		}
		}
        ubuntu: {
            apt::ppa { 'ppa:chris-lea/node.js': }
        }
        default: {
            fail("Unrecognized operating system for node.js repo")
        }
    }


    # souces for i3
	case $::operatingsystem {
    	debian: { 
			$repo = "main" 
		}
      	ubuntu: { 
			$repo = "universe"
		}
      	default: {
			fail("Unrecognized operating system for i3 repo")
		}
    }

	apt::source { 'i3-stable':
		location => 'http://debian.sur5r.net/i3',
		repos    => $repo,
		key      => '6298B4A2',
		pin      => 1001,
	}

}
