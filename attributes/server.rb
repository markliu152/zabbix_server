# General Zabbix information
default['zabbix']['server']['version'] = '2.4.6'
default['zabbix']['server']['enabled'] = 'false'
default['zabbix']['server']['repo'] = '/etc/yum.repos.d/zabbix.repo'


# Zabbix configuration settings
# All are zabbix defaults and should be updated in your Environment file or a role file.
default['zabbix']['server']['conf']['AlertScriptsPath'] = '/etc/zabbix/zabbix_server.conf.d/alertscripts'
default['zabbix']['server']['conf']['CacheSize'] = '8M'
default['zabbix']['server']['conf']['CacheUpdateFrequency'] = '60'
default['zabbix']['server']['conf']['DBHost'] = 'localhost'
default['zabbix']['server']['conf']['DBName'] = 'zabbix'
default['zabbix']['server']['conf']['DBUser'] = 'zabbix'
default['zabbix']['server']['conf']['DBPassword'] = ''
default['zabbix']['server']['conf']['DBSocket'] = '/var/lib/mysql/mysql.sock'
default['zabbix']['server']['conf']['ExternalScripts'] = '/etc/zabbix/zabbix_server.conf.d/externalscripts'
default['zabbix']['server']['conf']['HistoryCacheSize'] = '8M'
default['zabbix']['server']['conf']['HistoryTextCacheSize'] = '16M'
default['zabbix']['server']['conf']['ListenIP'] = '0.0.0.0'
default['zabbix']['server']['conf']['LogFile'] = '/var/log/zabbix/zabbix_server.log'
default['zabbix']['server']['conf']['LogFileSize'] = '0'
default['zabbix']['server']['conf']['LogSlowQueries'] = '0'
default['zabbix']['server']['conf']['PidFile'] = '/var/run/zabbix/zabbix_server.pid'
default['zabbix']['server']['conf']['StartDBSyncers'] = '4'
default['zabbix']['server']['conf']['StartDiscoverers'] = '1'
default['zabbix']['server']['conf']['StartHTTPPollers'] = '1'
default['zabbix']['server']['conf']['StartPollers'] = '5'
default['zabbix']['server']['conf']['StartPollersUnreachable'] = '1'
default['zabbix']['server']['conf']['StartTimers'] = '1'
default['zabbix']['server']['conf']['StartTrappers'] = '5'
#default['zabbix']['server']['conf']['SourceIP'] = ''
default['zabbix']['server']['conf']['TrendCacheSize'] = '4M'
default['zabbix']['server']['conf']['ValueCacheSize'] = '8M'
default['zabbix']['server']['conf']['SNMPTrapperFile'] = '/var/log/snmptt/snmptt.log'



default['zabbix']['server']['listen_port'] = '10050'

#PHP settings
default['zabbix']['php']['timezone'] = 'Europe/Riga'
default['zabbix']['php']['zabbix_listen'] = 'localhost'
default['zabbix']['php']['server_name'] = ''




# Mysql User info

default['zabbix']['mysql']['user'] = 'zabbix'
# Need to be moved to an encrypted databag
default['zabbix']['mysql']['password'] = ''
default['zabbix']['mysql']['zabbix_prep_dir'] = '/usr/share/doc/zabbix-server-mysql-'

