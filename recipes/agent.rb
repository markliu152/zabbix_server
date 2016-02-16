#Install zabbix agent
execute 'zabbix_repo_install' do
   command 'rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm'
   not_if { File.exist?("#{node['zabbix']['server']['repo']}")}
end

package 'zabbix-agent' do
 action :install
end

template 'zabbix_agent.conf' do
	path '/etc/zabbix/zabbix_agentd.conf'
	source 'zabbix_agent.conf.erb'
	mode 0644
	owner 'root'
	group 'root'
end

service 'zabbix-agent' do
	action [:enable, :start]
end