# coding: UTF-8
# attribute file name: apache
default['zabbix']['web']['directory_restrictions'] = %w(conf api include classes)
default['zabbix']['web']['frontend_dir'] = '/usr/share/zabbix'
default['zabbix']['web']['document_root'] = '/var/www/html'
default['zabbix']['web']['log_dir'] = '/var/log/httpd'
default['zabbix']['web']['access_log'] = 'access_log'
# rubocop:disable Style/StringLiterals
default['zabbix']['web']['log_format'] = "%h %l %u %t \\\"%r\\\" %>s %b \\\"%{Referer}i\\\" \\\"%{User-Agent}i\\\" %{Host}i %{X-Forwarded-For}i %T/%D %I %O"
# rubocop:enable Style/StringLiterals
default['zabbix']['web']['log_format_name'] = 'combined_plus_host_xff_timing_io'
default['zabbix']['web']['openid_rewrite'] = true

default['zabbix']['web']['basic_auth']['user_file'] = '/etc/httpd/zabbix-admin-users'

default['zabbix']['web']['php']['settings'] = {
  'memory_limit'        => '512M',
  'post_max_size'       => '32M',
  'upload_max_filesize' => '16M',
  'max_execution_time'  => '600',
  'max_input_time'      => '600',
  'date.timezone'       => "'UTC'"
}

default['zabbix']['web']['login'] = 'admin'
default['zabbix']['web']['password'] = 'zabbix'
default['zabbix']['web']['install_method'] = 'apache'
default['zabbix']['web']['fqdn'] = node['fqdn']
default['zabbix']['web']['server_aliases'] = ['zabbix']
default['zabbix']['web']['port'] = 80
default['zabbix']['web']['alias'] = %w(/zabbix /zabbix-admin /api)
