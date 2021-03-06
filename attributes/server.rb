# General Zabbix information for installation
default['zabbix']['server']['version'] = '3.0.1'
default['zabbix']['server']['release'] = '1.el7'
default['zabbix']['server']['enabled'] = 'false'
default['zabbix']['server']['repo'] = '/etc/yum.repos.d/zabbix.repo'

# Zabbix configuration settings
default['zabbix']['server']['conf']['AlertScriptsPath'] = '/etc/zabbix/zabbix_server.conf.d/alertscripts'
default['zabbix']['server']['conf']['AllowRoot'] = '0'
default['zabbix']['server']['conf']['CacheSize'] = '8M'
default['zabbix']['server']['conf']['CacheUpdateFrequency'] = '60'
default['zabbix']['server']['conf']['DBHost'] = 'localhost'
default['zabbix']['server']['conf']['DBName'] = 'zabbix'
default['zabbix']['server']['conf']['DBPassword'] = ''
default['zabbix']['server']['conf']['DBPort'] = '3306'
default['zabbix']['server']['conf']['DBSocket'] = '/var/lib/mysql/mysql.sock'
default['zabbix']['server']['conf']['DBUser'] = 'zabbix'
default['zabbix']['server']['conf']['DebugLevel'] = '3'
default['zabbix']['server']['conf']['ExternalScripts'] = '/etc/zabbix/zabbix_server.conf.d/externalscripts'
default['zabbix']['server']['conf']['HistoryCacheSize'] = '16M'
default['zabbix']['server']['conf']['HistoryIndexCacheSize'] = '4M'
default['zabbix']['server']['conf']['HousekeepingFrequency'] = '1'
default['zabbix']['server']['conf']['ListenIP'] = ''
default['zabbix']['server']['conf']['ListenPort'] = '10051'
default['zabbix']['server']['conf']['LogFile'] = '/var/log/zabbix/zabbix_server.log'
default['zabbix']['server']['conf']['LogFileSize'] = '1'
default['zabbix']['server']['conf']['LogType'] = 'file'
default['zabbix']['server']['conf']['LogSlowQueries'] = '0'
default['zabbix']['server']['conf']['MaxHousekeeperDelete'] = '5000'
default['zabbix']['server']['conf']['PidFile'] = '/var/run/zabbix/zabbix_server.pid'
default['zabbix']['server']['conf']['ProxyConfigFrequency'] = '3600'
default['zabbix']['server']['conf']['ProxyDataFrequency'] = '1'
default['zabbix']['server']['conf']['SenderFrequency'] = '30'
default['zabbix']['server']['conf']['SNMPTrapperFile'] = '/var/log/snmptt/snmptt.log'
default['zabbix']['server']['conf']['StartDBSyncers'] = '4'
default['zabbix']['server']['conf']['StartDiscoverers'] = '1'
default['zabbix']['server']['conf']['StartEscalators'] = '1'
default['zabbix']['server']['conf']['StartHTTPPollers'] = '1'
default['zabbix']['server']['conf']['StartIPMIPollers'] = '0'
default['zabbix']['server']['conf']['StartPingers'] = '1'
default['zabbix']['server']['conf']['StartPollersUnreachable'] = '1'
default['zabbix']['server']['conf']['StartPollers'] = '5'
default['zabbix']['server']['conf']['StartProxyPollers'] = '1'
default['zabbix']['server']['conf']['StartSNMPTrapper'] = '0'
default['zabbix']['server']['conf']['StartTimers'] = '1'
default['zabbix']['server']['conf']['StartTrappers'] = '5'
default['zabbix']['server']['conf']['Timeout'] = '3'
default['zabbix']['server']['conf']['TrapperTimeout'] = '300'
default['zabbix']['server']['conf']['TrendCacheSize'] = '4M'
default['zabbix']['server']['conf']['UnavailableDelay'] = '60'
default['zabbix']['server']['conf']['UnreachableDelay'] = '15'
default['zabbix']['server']['conf']['UnreachablePeriod'] = '45'
default['zabbix']['server']['conf']['User'] = 'zabbix'
default['zabbix']['server']['conf']['ValueCacheSize'] = '8M'

# PHP settings
default['zabbix']['php']['timezone'] = 'America/Central'
default['zabbix']['php']['zabbix_listen'] = 'localhost'
default['zabbix']['php']['server_name'] = ''

# logrotate options
default['zabbix']['logrotate']['frequency'] = 'monthly'
default['zabbix']['logrotate']['rotate'] = 3
default['zabbix']['logrotate']['options'] = %w(compress missingok notifempty)

default['zabbix']['server']['mysql_templates'] = "/usr/share/doc/zabbix-server-mysql-#{node['zabbix']['server']['version']}"
