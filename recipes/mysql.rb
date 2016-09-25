#
# Cookbook Name:: zabbix_server
# Recipe:: mysql
#
# Copyright 2016
#
# All rights reserved - Do Not Redistribute
#
# Install mysql packages
node['zabbix']['mysql']['package_list'].each do |pkg|
  package pkg do
    action :install
  end
end

# Pull information from databags
mysql_secret = Chef::EncryptedDataBagItem.load_secret(node['zabbix']['data_bag_secret_path'])
mysql_databag = Chef::EncryptedDataBagItem.load(node['zabbix']['data_bag_name'], node['zabbix']['data_bag_item'], mysql_secret)
dbpassword = mysql_databag['mysql_user_password']
mysql_root_password = mysql_databag['mysql_root_password']

template '/etc/my.cnf' do
  source 'my.cnf.erb'
  mode '664'
  notifies  :restart, 'service[mysql]', :delayed
end

rundir = File.dirname(node['mysql']['conf']['mysqld']['pid-file'])
logdir = File.dirname(node['mysql']['conf']['mysqld']['log-error'])
[rundir, logdir].each do |dir|
  directory dir do
    owner 'mysql'
    group 'mysql'
    mode '755'
    recursive true
    action :create
  end
end

file node['mysql']['conf']['mysqld']['log-error'] do
  owner 'mysql'
  group 'mysql'
  mode '644'
end

logrotate_app 'mysql' do
  cookbook 'logrotate'
  path [node['mysql']['conf']['mysqld']['log-error']]
  options node['mysql']['logrotate']['options']
  frequency node['mysql']['logrotate']['frequency']
  rotate node['mysql']['logrotate']['rotate']
  create '640 mysql mysqllogs'
  postrotate node['mysql']['logrotate']['postrotate']
end

service 'mysql' do
  action [:enable, :start]
end

# Secure mysql and update mysql root password
bash 'MySQL secure installation' do
  user 'root'
  code <<-EOH
  /usr/bin/mysql_secure_installation <<EOF

  y
  #{mysql_root_password}
  #{mysql_root_password}
  y
  y
  y
  y
  EOF
  EOH
  only_if "mysql -u root -e 'exit' && test ! -f /root/.my.cnf"
end

# Setup a mysql auth file
template '/root/.my.cnf' do
  source '.my.cnf.erb'
  owner 'root'
  group 'root'
  mode '664'
end

# Setup Zabbix database
execute 'MySQL Zabbix Database create' do
  command "mysql --user=root --password=#{mysql_root_password} -e \"create database zabbix character set utf8 collate utf8_bin;\""
  not_if "mysqlshow --user=root --password=#{mysql_root_password} zabbix"
end

# Setup mysql user
bash 'MySQL Zabbix Database user create' do
  user 'root'
  code <<-EOH
  mysql --user=root --password=#{mysql_root_password} -e "CREATE USER '#{node['zabbix']['server']['conf']['DBUser']}'@'#{node['zabbix']['server']['conf']['DBHost']}' IDENTIFIED BY '#{dbpassword}';"
  mysql --user=root --password=#{mysql_root_password} -e "GRANT ALL PRIVILEGES ON zabbix.* TO '#{node['zabbix']['server']['conf']['DBUser']}'@'#{node['zabbix']['server']['conf']['DBHost']}';"
  EOH
  not_if "mysql --user=root --password=#{mysql_root_password} -e \"SHOW GRANTS FOR '#{node['zabbix']['server']['conf']['DBUser']}'@'#{node['zabbix']['server']['conf']['DBHost']}';\""
end
