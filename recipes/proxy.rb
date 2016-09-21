#
# Cookbook Name:: zabbix_server
# Recipe:: proxy
#
# Copyright 2016
#
# All rights reserved - Do Not Redistribute
#
# Load Databag
databag_secret = Chef::EncryptedDataBagItem.load_secret(node['zabbix']['data_bag_secret_path'])
databag_passwords = Chef::EncryptedDataBagItem.load(node['zabbix']['data_bag_name'], node['zabbix']['data_bag_item'], databag_secret)
dbpassword = databag_passwords['mysql_user_password']
mysql_root_password = databag_passwords['mysql_root_password']

include_recipe 'zabbix_server::_java_gateway' if node['zabbix']['zabbix_java_gateway']

package 'zabbix-proxy-mysql' do
  action :install
  version "#{node['zabbix']['proxy']['version']}-#{node['zabbix']['proxy']['package_version']}"
end

script_dirs = node['zabbix']['proxy']['conf']['ExternalScripts']

directory script_dirs do
  owner 'zabbix'
  group 'zabbix'
  mode '755'
  action :create
  recursive true
end

bash 'load database data' do
  user 'root'
  cwd node['zabbix']['proxy']['mysql_templates'].to_s
  code <<-EOH
  zcat #{node['zabbix']['proxy']['mysql_templates']}/schema.sql.gz | mysql -uroot zabbix
  EOH
  not_if "mysqlshow --user=root --password=#{mysql_root_password} zabbix images"
end

file node['zabbix']['proxy']['conf']['LogFile'] do
  mode '640'
  owner 'zabbix'
  group 'zabbix'
  action :create
end

logrotate_app 'zabbix-proxy' do
  cookbook 'logrotate'
  path [node['zabbix']['proxy']['conf']['LogFile']]
  options node['zabbix']['logrotate']['options']
  frequency node['zabbix']['logrotate']['frequency']
  rotate node['zabbix']['logrotate']['rotate']
  create '640 zabbix zabbixlogs'
end

if node['zabbix']['proxy']['conf']['Hostname'].empty?
  node.default['zabbix']['proxy']['conf']['Hostname'] == :hostname
end
node.default['zabbix']['proxy']['conf']['DBPassword'] = dbpassword
template 'zabbix_proxy.conf' do
  path '/etc/zabbix/zabbix_proxy.conf'
  source 'zabbix_proxy.conf.erb'
  mode '644'
  owner 'zabbix'
  group 'zabbix'
  action :create
end

service 'zabbix-proxy' do
  action [:enable, :start]
end
