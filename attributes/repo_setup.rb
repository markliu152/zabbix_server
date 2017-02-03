# coding: UTF-8
# Attributes for repo_setup recipe
#
# Attributes for zabbix repo
default['yum']['zabbix']['repo_url'] = "http://repo.zabbix.com/zabbix/#{node['zabbix']['repo']['version']}/rhel/7/$basearch/"
default['yum']['zabbix']['mirror_url'] = nil
default['yum']['zabbix']['key_url'] = 'http://repo.zabbix.com/RPM-GPG-KEY-ZABBIX'
default['yum']['zabbix']['gpgcheck'] = false

# Attributes for mariaDB repo
default['yum']['mariaDB']['repo_url'] = 'https://yum.mariadb.org/5.5.51/centos7-amd64'
default['yum']['mariaDB']['mirror_url'] = nil
default['yum']['mariaDB']['key_url'] = 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'

# Attributes for percona repo
default['yum']['percona']['repo_url'] = "http://repo.percona.com/centos/#{node['platform_version'].split('.').first}/os/$basearch/"
default['yum']['percona']['mirror_url'] = nil
default['yum']['percona']['key_url'] = 'http://www.percona.com/downloads/RPM-GPG-KEY-percona'

# Attributes for webtatic repo
default['yum']['webtatic']['repo_url'] = nil
default['yum']['webtatic']['mirror_url'] = 'http://mirror.webtatic.com/yum/el7-archive/$basearch/mirrorlist'
default['yum']['webtatic']['key_url'] = 'http://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-el7'
