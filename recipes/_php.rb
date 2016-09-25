# coding: UTF-8

node['php']['package_list'].each do |package|
  yum_package package do
    action :install
    options '--quiet'
  end
end

cookbook_file "#{Chef::Config[:file_cache_path]}/xcache-#{node['php']['xcache']['version']}.tar.gz" do
  source "php/xcache-#{node['php']['xcache']['version']}.tar.gz"
  action :create_if_missing
end

execute 'explode file' do
  command "tar xf #{Chef::Config[:file_cache_path]}/xcache-#{node['php']['xcache']['version']}.tar.gz -C #{Chef::Config[:file_cache_path]}"
end

# Build xcache from source
bash 'Build xcache' do
  cwd "#{Chef::Config[:file_cache_path]}/xcache-#{node['php']['xcache']['version']}"
  code <<-EOH
  phpize --clean > /dev/null && phpize > /dev/null
  ./configure --enable-xcache > /dev/null
  make > /dev/null
  su
  make install > /dev/null
  cp -R ./htdocs/ #{node['zabbix']['web']['document_root']}/xcache-admin
  EOH
  not_if "php -i|grep \"XCache Version => #{node['php']['xcache']['version']}\""
  notifies :reload, 'service[apache2]'
end

# Cleanup if chef-solo
directory "#{Chef::Config[:file_cache_path]}/xcache-#{node['php']['xcache']['version']}" do
  action :delete
  recursive true
  only_if { Chef::Config[:solo] }
end

file "#{Chef::Config[:file_cache_path]}/xcache-#{node['php']['xcache']['version']}.tar.gz" do
  action :delete
  only_if { Chef::Config[:solo] }
end

template '/etc/php.ini' do
  source 'php/php.ini.erb'
  backup 5
  mode '644'
  notifies :reload, 'service[apache2]'
end
