# General Zabbix Proxy settings for installtion
default['zabbix']['proxy']['version'] = '3.0.1'
default['zabbix']['proxy']['package_version'] = '1.el7'
default['zabbix']['proxy']['mysql_templates'] = "/usr/share/doc/zabbix-proxy-mysql-#{node['zabbix']['proxy']['version']}"

# zabbix_proxy.conf attributes that needs to be overriden
default['zabbix']['proxy']['conf']['Hostname'] = ''
default['zabbix']['proxy']['conf']['Server'] = ''

# JAVA GATEWAY SETTINGS
# If you would like to use a java gateway, override to true.
default['zabbix']['zabbix_java_gateway'] = false
# If the above is true set this to the same IP the zabbix-proxy is listening on.
default['zabbix']['proxy']['conf']['JavaGateway'] = 'useless_value_spaceholder'
# If you set :zabbix_java_gateway to true then set :StartJavaPollers greater than 0.
default['zabbix']['proxy']['conf']['StartJavaPollers'] = '0'
default['zabbix']['proxy']['conf']['JavaGatewayPort'] = '10052'

# zabbix_proxy.conf attributes
default['zabbix']['proxy']['conf']['AllowRoot'] = '0'
default['zabbix']['proxy']['conf']['CacheSize'] = '8M'
default['zabbix']['proxy']['conf']['ConfigFrequency'] = '3600'
default['zabbix']['proxy']['conf']['DBHost'] = 'localhost'
default['zabbix']['proxy']['conf']['DBName'] = 'zabbix'
default['zabbix']['proxy']['conf']['DBPassword'] = ''
default['zabbix']['proxy']['conf']['DBSocket'] = '3306'
default['zabbix']['proxy']['conf']['DBUser'] = 'zabbix'
default['zabbix']['proxy']['conf']['DataSenderFrequency'] = '1'
default['zabbix']['proxy']['conf']['DebugLevel'] = '3'
default['zabbix']['proxy']['conf']['ExternalScripts'] = '/etc/zabbix/zabbix_proxy.conf.d/externalscripts'
default['zabbix']['proxy']['conf']['HeartbeatFrequency'] = '60'
default['zabbix']['proxy']['conf']['HistoryCacheSize'] = '16M'
default['zabbix']['proxy']['conf']['HistoryIndexCacheSize'] = '4M'
default['zabbix']['proxy']['conf']['HousekeepingFrequency'] = '1'
default['zabbix']['proxy']['conf']['ListenIP'] = '0.0.0.0'
default['zabbix']['proxy']['conf']['ListenPort'] = '10051'
default['zabbix']['proxy']['conf']['LogFile'] = '/var/log/zabbix/zabbix_proxy.log'
default['zabbix']['proxy']['conf']['LogFileSize'] = '1'
default['zabbix']['proxy']['conf']['LogType'] = 'file'
default['zabbix']['proxy']['conf']['LogSlowQueries'] = '0'
default['zabbix']['proxy']['conf']['PidFile'] = '/var/run/zabbix/zabbix_proxy.pid'
default['zabbix']['proxy']['conf']['ProxyLocalBuffer'] = '0'
default['zabbix']['proxy']['conf']['ProxyMode'] = '0'
default['zabbix']['proxy']['conf']['ProxyOfflineBuffer'] = '1'
default['zabbix']['proxy']['conf']['ServerPort'] = '10051'
default['zabbix']['proxy']['conf']['StartDBSyncers'] = '4'
default['zabbix']['proxy']['conf']['StartDiscoverers'] = '1'
default['zabbix']['proxy']['conf']['StartHTTPPollers'] = '1'
default['zabbix']['proxy']['conf']['StartIPMIPollers'] = '0'
default['zabbix']['proxy']['conf']['StartPingers'] = '1'
default['zabbix']['proxy']['conf']['StartPollersUnreachable'] = '1'
default['zabbix']['proxy']['conf']['StartPollers'] = '5'
default['zabbix']['proxy']['conf']['StartTrappers'] = '5'
default['zabbix']['proxy']['conf']['Timeout'] = '3'
default['zabbix']['proxy']['conf']['TrapperTimeout'] = '300'
default['zabbix']['proxy']['conf']['User'] = 'zabbix'
default['zabbix']['proxy']['conf']['UnavailableDelay'] = '60'
default['zabbix']['proxy']['conf']['UnreachableDelay'] = '15'
default['zabbix']['proxy']['conf']['UnreachablePeriod'] = '45'

# logrotate options
default['zabbix']['logrotate']['frequency'] = 'monthly'
default['zabbix']['logrotate']['rotate'] = 3
default['zabbix']['logrotate']['options'] = %w(compress missingok notifempty)
