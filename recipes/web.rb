#
# Cookbook Name:: zabbix_server
# Recipe:: server
#
# Copyright 2016
#
# All rights reserved - Do Not Redistribute
#
# Pull data from databags
databag_secret = Chef::EncryptedDataBagItem.load_secret(node['zabbix']['data_bag_secret_path'])
databag_passwords = Chef::EncryptedDataBagItem.load(node['zabbix']['data_bag_name'], node['zabbix']['data_bag_item'], databag_secret)
dbpassword = databag_passwords['mysql_user_password']
web_ui_password = databag_passwords['web_ui_password']

execute 'set HTTP authentication' do
  command <<-EOH
    mysql -u#{node['zabbix']['server']['conf']['DBUser']} -p#{dbpassword} zabbix -e "update config set authentication_type=0"
  EOH
end

include_recipe 'zabbix_server::_php'

package 'zabbix-web-mysql' do
  version "#{node['zabbix']['server']['version']}-#{node['zabbix']['server']['release']}"
  action :install
end

# include_recipe 'apache2'

execute 'add zabbix admin user' do
  command "htpasswd -cb #{node['zabbix']['web']['basic_auth']['user_file']} Admin #{web_ui_password}"
  not_if { File.exist? node['zabbix']['web']['basic_auth']['user_file'] }
end

# create /etc/zabbix/web
directory '/etc/zabbix/web' do
  owner 'zabbix'
  group 'zabbix'
  mode '755'
end

# Setup the zabbix web config
template '/etc/zabbix/web/zabbix.conf.php' do
  source 'zabbix.conf.php.erb'
  mode '644'
  owner 'apache'
  group 'apache'
  variables database_password: dbpassword
  action :create
end

apache_conf 'php' do
  enable true
end

web_app node['zabbix']['web']['fqdn'] do
  template 'zabbix_app.conf.erb'
  server_name node['zabbix']['web']['fqdn']
  server_port node['zabbix']['web']['port']
  docroot node['zabbix']['web']['document_root']
  zabbix_web_dir node['zabbix']['web']['frontend_dir']
  server_aliases node['zabbix']['web']['server_aliases']
  php_settings node['zabbix']['web']['php']['settings']
  web_alias node['zabbix']['web']['alias']
  dir_restrict_access node['zabbix']['web']['directory_restrictions']
  basic_auth_file node['zabbix']['web']['basic_auth']['user_file']
  log_format node['zabbix']['web']['log_format']
  log_format_name node['zabbix']['web']['log_format_name']
  log_dir node['zabbix']['web']['log_dir']
  access_log node['zabbix']['web']['access_log']
  openid_env node['zabbix']['web']['openid_rewrite']
  notifies :restart, 'service[apache2]', :immediately
end

directory node['zabbix']['web']['log_dir'] do
  owner 'apache'
  group 'apache'
  mode '755'
end
