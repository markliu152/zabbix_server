# coding: UTF-8

unless node.recipe?('ops_zabbix_server::zabbix_proxy')
  raise 'The Java Gateway has to be installed on a server with the Zabbix Proxy recipe.'
end

node.default['zabbix']['proxy']['conf']['StartJavaPollers'] = '10'

node.default['zabbix']['proxy']['conf']['JavaGateway'] = node['ipaddress']

include_recipe 'java'

# installation of zabbix Java Gateway
yum_package 'zabbix-java-gateway' do
  action :install
  version "#{node['zabbix']['proxy']['version']}-#{node['zabbix']['proxy']['package_version']}"
end

template '/etc/zabbix/zabbix_java_gateway.conf' do
  source 'zabbix_java_gateway.conf.erb'
  mode '644'
  owner 'zabbix'
  group 'zabbix'
  action :create
  notifies :restart, 'service[zabbix-java-gateway]'
end

service 'zabbix-java-gateway' do
  action [:enable, :start]
end
