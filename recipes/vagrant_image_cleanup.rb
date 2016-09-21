#
# Cookbook Name:: zabbix_server
# Recipe:: vagrant_image_cleanup
#
# Copyright 2016
#
# All rights reserved - Do Not Redistribute
#
package 'mariadb-libs' do
  action :remove
end
