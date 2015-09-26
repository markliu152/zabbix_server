# Install the zabbix 2.4 repo

   execute 'zabbix_repo_install' do
      command 'rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm'
      not_if { File.exist?("#{node['zabbix']['server']['repo']}")}
   end

package ['zabbix-server-mysql', 'zabbix-web-mysql']  do
  action :install
end


mysqluser = node['zabbix']['mysql']['user']
mysqlpassword = node['zabbix']['mysql']['password']
unless Dir.exist? "#{node['zabbix']['mysql']['zabbix_dir']}"
   execute 'prep_mysql_db' do
	   command "mysql -e \"create database zabbix character set utf8 collate utf8_bin; grant all privileges on zabbix.* to #{mysqluser}@localhost identified by '#{mysqlpassword}';\""
   end
end

unless File.exist? "#{node['zabbix']['mysql']['zabbix_dir']}/maintenances.frm"
   execute 'mysql_import_schema' do
	   command "mysql -u#{node['zabbix']['mysql']['user']} -p#{node['zabbix']['mysql']['password']} zabbix < #{node['zabbix']['mysql']['zabbix_prep_dir']}#{node['zabbix']['server']['version']}/create/schema.sql"
   end

   execute 'mysql_import' do
	   command "mysql -u#{node['zabbix']['mysql']['user']} -p#{node['zabbix']['mysql']['password']} zabbix < #{node['zabbix']['mysql']['zabbix_prep_dir']}#{node['zabbix']['server']['version']}/create/images.sql"
   end

   execute 'mysql_import_data' do
	    command "mysql -u#{node['zabbix']['mysql']['user']} -p#{node['zabbix']['mysql']['password']} zabbix < #{node['zabbix']['mysql']['zabbix_prep_dir']}#{node['zabbix']['server']['version']}/create/data.sql"
   end
end

directory '/etc/zabbix/zabbix_server.conf.d' do
  owner 'root'
  group 'zabbix'
  mode '0755'
  action :create
end



template 'zabbix_server.conf' do
	path '/etc/zabbix/zabbix_server.conf'
	source 'zabbix_server.conf.erb'
	mode 0640
	owner 'root'
	group 'zabbix'
end

template 'zabbix.conf' do
	path '/etc/httpd/conf.d/zabbix.conf'
	source 'zabbix.conf.erb'
	mode 0644
	owner 'root'
	group 'root'
end

template 'zabbix.conf.php' do
	path '/etc/zabbix/web/zabbix.conf.php'
	source 'zabbix.conf.php.erb.html'
	mode 0644
	owner 'root'
	group 'root'
end

seenabled = `getenforce`
if '#{seenabled}' == 'Enabled' then
   execute 'selinux_policy' do
	   command 'setsebool -P httpd_can_network_connect on'
	   command 'setsebool -P zabbix_can_network on'
   end
end

directory '/etc/iptables.d' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

iptables_rule 'zabbix_firewall' do
	action :enable
end

service 'zabbix-server' do
	action [:enable, :restart]
end

service 'httpd' do
	action [:enable, :restart]
end

