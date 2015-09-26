#Install zabbix agent
package 'zabbix-agent' do
 action :install
end

template 'zabbix_agent.conf' do
	path '/etc/zabbix/zabbix_agent.conf'
	source 'zabbix_agent.conf.erb'
	mode 0644
	owner 'root'
	group 'root'
end

service 'zabbix-agent' do
	action [:enable, :start]
end