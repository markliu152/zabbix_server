name             'zabbix_server'
maintainer       'Som3guy'
maintainer_email 'N/A'
license          'All rights reserved'
description      'Installs/Configures zabbix'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
issues_url 'https://github.com/som3guy/sickrage/issues' if respond_to?(:issues_url)
source_url 'https://github.com/som3guy/sickrage.git' if respond_to?(:source_url)

supports 'centos', '>= 7.0'

depends 'yum-epel', '~> 1.0.0'
depends 'logrotate', '~> 2.1.0'
depends 'apache2', '~> 3.2.2'
depends 'java', '~> 1.42.0'
