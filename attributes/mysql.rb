# Mysql password
default['zabbix']['mysql']['root_password'] = ''
default['zabbix']['mysql']['server_type'] = 'MYSQL'
default['zabbix']['mysql']['port'] = '3306'
default['zabbix']['mysql']['zabbix_dir'] = '/var/lib/mysql/zabbix'
default['zabbix']['mysql']['version'] = '5.5.45-1.el6'
default['zabbix']['mysql']['package_list'] = ['MariaDB-compat', 'MariaDB-common', 'MariaDB-devel', 'MariaDB-shared', 'MariaDB-client', 'MariaDB-test', 'MariaDB-Galera-server', 'galera', 'percona-xtrabackup']

# Mysql User info
default['zabbix']['mysql']['user'] = 'zabbix'

# Need to be moved to an encrypted databag
default['zabbix']['mysql']['password'] = ''
default['zabbix']['mysql']['zabbix_prep_dir'] = '/usr/share/doc/zabbix-server-mysql-'

# config
# client stack
default['mysql']['conf']['client']['port']                       = '3306'
default['mysql']['conf']['client']['socket']                     = '/var/lib/mysql/mysql.sock'

# mysqld options
default['mysql']['conf']['mysqld']['server-id']                  = '1'
default['mysql']['conf']['mysqld']['port']                       = '3306'
default['mysql']['conf']['mysqld']['binlog_cache_size']          = '1M'
default['mysql']['conf']['mysqld']['binlog-do-db']               = 'zabbix'
default['mysql']['conf']['mysqld']['binlog_format']              = 'ROW'
default['mysql']['conf']['mysqld']['binlog-row-event-max-size']  = '8192'
default['mysql']['conf']['mysqld']['datadir']                    = '/var/lib/mysql'
default['mysql']['conf']['mysqld']['innodb_concurrency_tickets'] = '500'
default['mysql']['conf']['mysqld']['innodb_flush_log_at_trx_commit'] = '0'
default['mysql']['conf']['mysqld']['innodb_flush_method']        = 'O_DSYNC'
default['mysql']['conf']['mysqld']['innodb_log_file_size']       = '256M'
default['mysql']['conf']['mysqld']['innodb_old_blocks_time']     = '1000'
default['mysql']['conf']['mysqld']['innodb_open_files']          = '300'
default['mysql']['conf']['mysqld']['innodb_stats_on_metadata']   = 'ON'
default['mysql']['conf']['mysqld']['ignore-db-dir']              = ['lost+found']
default['mysql']['conf']['mysqld']['join_buffer_size']           = '128k'
default['mysql']['conf']['mysqld']['log-bin']                    = 'mysql-bin'
default['mysql']['conf']['mysqld']['log-error']                  = '/var/log/mysql/mysqld.log'
default['mysql']['conf']['mysqld']['max_allowed_packet']         = '16M'
default['mysql']['conf']['mysqld']['max_connect_errors']         = '10000'
default['mysql']['conf']['mysqld']['max_connections']            = '600'
default['mysql']['conf']['mysqld']['max_heap_table_size']        = '256M'
default['mysql']['conf']['mysqld']['net_buffer_length']          = '8K'
default['mysql']['conf']['mysqld']['port']                       = '3306'
default['mysql']['conf']['mysqld']['pid-file']                   = '/var/run/mysqld.pid'
default['mysql']['conf']['mysqld']['query_cache_size']           = '128M'
default['mysql']['conf']['mysqld']['query_cache_type']           = '1'
default['mysql']['conf']['mysqld']['read_buffer_size']           = '1M'
default['mysql']['conf']['mysqld']['relay-log-recovery']         = '1'
default['mysql']['conf']['mysqld']['relay-log-space-limit']      = '2G'
default['mysql']['conf']['mysqld']['replicate-do-db']            = 'zabbix'
default['mysql']['conf']['mysqld']['replicate-ignore-db']        = 'mysql, performance_schema, lost+found'
default['mysql']['conf']['mysqld']['slave-skip-error']           = '1062'
default['mysql']['conf']['mysqld']['socket']                     = '/var/lib/mysql/mysql.sock'
default['mysql']['conf']['mysqld']['sort_buffer_size']           = '1M'
default['mysql']['conf']['mysqld']['table_open_cache']           = '1024'
default['mysql']['conf']['mysqld']['tmp_table_size']             = '1G'
default['mysql']['conf']['mysqld']['wait_timeout']               = '28800'
default['mysql']['conf']['mysqld']['slow-query-log']             = '1'
default['mysql']['conf']['mysqld']['slow-query-log-file']        = '/etc/var/log/mysql_slow.log'
default['mysql']['conf']['innodb_file_per_table']                = 'innodb_file_per_table'
default['mysql']['conf']['innodb_write_io_threads']              = '8'
default['mysql']['conf']['innodb_read_io_threads']               = '4'
default['mysql']['conf']['innodb_max_dirty_pages_pct']           = '75'
default['mysql']['conf']['innodb_io_capacity']                   = '200'
default['mysql']['conf']['skip-slave-start']                     = 'skip-slave-start'

# mysqldump stack
default['mysql']['conf']['quick']                                = 'quick'
default['mysql']['conf']['mysqldump']['max_allowed_packet']      = '16M'

# mysql stack
default['mysql']['conf']['mysql']['no-auto-rehash']              = 'no-auto-rehash'

# mysqlhotcopy stack
default['mysql']['conf']['interactive-timeout']                  = 'interactive-timeout'

# mysqld_safe stack
default['mysql']['conf']['mysqld_safe']['pid-file']              = '/var/run/mysqld/mysqld.pid'

# Log Rotate option
default['mysql']['logrotate']['frequency'] = 'daily'
default['mysql']['logrotate']['rotate'] = 3
default['mysql']['logrotate']['options'] = %w(compress missingok notifempty)
default['mysql']['logrotate']['postrotate'] = 'if test -x /usr/bin/mysqladmin && /usr/bin/mysqladmin ping &>/dev/null; then /usr/bin/mysqladmin flush-logs; fi'
