# Mysql password

default['zabbix']['mysql']['root_password'] = ''
default['zabbix']['mysql']['server_type'] = 'MYSQL'
default['zabbix']['mysql']['port'] = '3306'
default['zabbix']['mysql']['zabbix_dir'] = '/var/lib/mysql/zabbix'
default['zabbix']['mysql']['version'] = '5.5.45-1.el6'

# Mysql User info

default['zabbix']['mysql']['user'] = 'zabbix'
# Need to be moved to an encrypted databag
default['zabbix']['mysql']['password'] = ''
default['zabbix']['mysql']['zabbix_prep_dir'] = '/usr/share/doc/zabbix-server-mysql-'