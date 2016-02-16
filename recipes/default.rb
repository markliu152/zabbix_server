#
# Cookbook Name:: zabbix
# Recipe:: default
#
# Copyright 2015
#
# All rights reserved - Do Not Redistribute
#

if node['zabbix']['server']['enabled'] == 'true' then
    include_recipe 'zabbix::mariadb'
end

if node['zabbix']['server']['enabled'] == 'true' then
    include_recipe 'zabbix::server'
end

if node['zabbix']['agent']['enabled'] == 'true' then
    include_recipe 'zabbix::agent'
end