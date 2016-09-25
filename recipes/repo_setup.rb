#
# Cookbook Name:: zabbix_server
# Recipe:: server
#
# Copyright 2016
#
# All rights reserved - Do Not Redistribute
#
# Sets up webtatic yum repo
include_recipe 'yum-epel'
yum_repository 'webtatic' do
  name 'webtatic'
  description 'webtatic'
  baseurl node['yum']['webtatic']['repo_url'] if node['yum']['webtatic']['mirror_url'].nil?
  gpgkey node['yum']['webtatic']['key_url']
  mirrorlist node['yum']['webtatic']['mirror_url']
  action :create
  only_if { node['zabbix']['install_type'] == 'server' }
end

# Sets up mariaDB yum repo
yum_repository 'MariaDB' do
  name 'MariaDB'
  description 'MariaDB'
  baseurl node['yum']['mariaDB']['repo_url'] if node['yum']['mariaDB']['mirror_url'].nil?
  gpgkey node['yum']['mariaDB']['key_url']
  mirrorlist node['yum']['mariaDB']['mirror_url']
  action :create
end

# Sets up zabbix yum repo
yum_repository 'zabbix' do
  name 'zabbix'
  description 'zabbix'
  baseurl node['yum']['zabbix']['repo_url'] if node['yum']['zabbix']['mirror_url'].nil?
  gpgkey node['yum']['zabbix']['key_url']
  mirrorlist node['yum']['zabbix']['mirror_url']
  action :create
end

# Sets up percona yum repo
yum_repository 'percona' do
  name 'percona'
  description 'percona-repo'
  baseurl node['yum']['percona']['repo_url'] if node['yum']['percona']['mirror_url'].nil?
  gpgkey node['yum']['percona']['key_url']
  mirrorlist node['yum']['percona']['mirror_url']
  action :create
end
