#
# Cookbook Name:: zabbix_server
# Recipe:: default
#
# Copyright 2016
#
# All rights reserved - Do Not Redistribute
#
# Attribute check
error = ''
if node['zabbix']['install_type'].empty?
  error << "You must set node['zabbix']['install_type'] \n"
end
raise error unless error.empty?

if node['zabbix']['server']['conf']['ListenIP'].empty?
  node.default['zabbix']['server']['conf']['ListenIP'] = node['ipaddress']
end

# Recipes
case node['platform_family']
when 'rhel'
  include_recipe 'zabbix_server::repo_setup'
  include_recipe 'zabbix_server::mysql'
  include_recipe "zabbix_server::#{node['zabbix']['install_type']}"
  include_recipe 'zabbix_server::web' if node['zabbix']['install_type'] == 'server'
else
  raise 'Installation not currently supported on this platform_family!'
end
