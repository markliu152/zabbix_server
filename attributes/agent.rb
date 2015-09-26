# Zabbix agent general
default['zabbix']['agent']['enabled'] = 'false'
# Zabbix Agent attributes
default['zabbix']['agent']['PidFile'] = '/var/run/zabbix/zabbix_agentd.pid'
default['zabbix']['agent']['LogFile'] = '/var/log/zabbix/zabbix_agentd.log'
default['zabbix']['agent']['LogFileSize'] = '0'
default['zabbix']['agent']['EnableRemoteCommands'] = '1'
default['zabbix']['agent']['Server'] = '127.0.0.1'
default['zabbix']['agent']['ServerActive'] = '127.0.0.1'
default['zabbix']['agent']['Hostname'] = ''
default['zabbix']['agent']['Include'] = '/etc/zabbix/zabbix_agentd.d/'