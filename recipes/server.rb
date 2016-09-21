#
# Cookbook Name:: zabbix_server
# Recipe:: server
#
# Copyright 2016
#
# All rights reserved - Do Not Redistribute
#
databag_secret = Chef::EncryptedDataBagItem.load_secret(node['zabbix']['data_bag_secret_path'])
databag_passwords = Chef::EncryptedDataBagItem.load(node['zabbix']['data_bag_name'], node['zabbix']['data_bag_item'], databag_secret)
dbpassword = databag_passwords['mysql_user_password']
mysql_root_password = databag_passwords['mysql_root_password']

package 'Installing Zabbix Server' do
  package_name 'zabbix-server-mysql'
  version "#{node['zabbix']['server']['version']}-#{node['zabbix']['server']['release']}"
end

script_dirs = [node['zabbix']['server']['conf']['ExternalScripts'].to_s, node['zabbix']['server']['conf']['AlertScriptsPath'].to_s]

script_dirs.each do |dir|
  directory dir do
    owner 'zabbix'
    group 'zabbix'
    mode '755'
    action :create
    recursive true
  end
end

# Create a group to assign to the zabbix logs
group 'zabbixlogs' do
  action :create
  members ['zabbix']
  append true
end

# Change the permissions on the log files
log_files = [
  node['zabbix']['server']['conf']['LogFile']
]

log_files.each do |log|
  file log do
    mode '644'
    owner 'zabbix'
    group 'zabbix'
    action :create
  end
end

logrotate_app 'zabbix-server' do
  cookbook 'logrotate'
  path [node['zabbix']['server']['conf']['LogFile']]
  options node['zabbix']['logrotate']['options']
  frequency node['zabbix']['logrotate']['frequency']
  rotate node['zabbix']['logrotate']['rotate']
  create '640 zabbix zabbixlogs'
end

node.default['zabbix']['server']['conf']['DBPassword'] = dbpassword
template 'zabbix_server.conf' do
  path '/etc/zabbix/zabbix_server.conf'
  source 'zabbix_server.conf.erb'
  mode '644'
  owner 'zabbix'
  group 'zabbix'
  action :create
end

bash 'load database data' do
  user 'root'
  cwd node['zabbix']['server']['mysql_templates'].to_s
  code <<-EOH
  zcat #{node['zabbix']['server']['mysql_templates']}/create.sql.gz | mysql -uroot zabbix
  EOH
  not_if "mysqlshow --user=root --password=#{mysql_root_password} zabbix images"
end

include_recipe 'zabbix_server::_partition_database'

service 'zabbix-server' do
  action [:enable, :start]
end
