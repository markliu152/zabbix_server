# coding: UTF-8

# Mysql/Mariadb SQL procedures taken from the zabbix wiki page on how to partition mysql zabbix database.
# Zabbix wiki page::https://www.zabbix.org/wiki/Docs/howto/mysql_partition

if node['zabbix']['partition_database']['perform_partition']
  # This resource will cause a READ-LOCK
  %w(history_text history_log).each do |table_to_alter|
    bash "alter_#{table_to_alter}" do
      code <<-EOH
      mysql -e \"Alter table zabbix.#{table_to_alter} drop primary key, add index (id), drop index #{table_to_alter}_2, add index #{table_to_alter}_2 (itemid, id)\";
      EOH
      action :run
      only_if "mysql -e \"describe zabbix.#{table_to_alter}\"| grep PRI"
    end
  end

  template "#{Chef::Config[:file_cache_path]}/zabbix_mysql_partition.sql" do
    source 'mysql/zabbix_mysql_partition.sql.erb'
    notifies :run, 'bash[partition_setup]', :immediately
  end

  # Adds all the procedures from the zabbix_mysql_partition.sql file to the database

  bash 'partition_setup' do
    code <<-EOH
    mysql #{node['zabbix']['server']['conf']['DBName']} < #{Chef::Config[:file_cache_path]}/zabbix_mysql_partition.sql
    EOH
    action :nothing
  end

  # partition_maintenance_all runs partition_maintenance procedure on all the tables that we have partitioned

  bash 'partition_tables' do
    code <<-EOH
    mysql #{node['zabbix']['server']['conf']['DBName']} -e \"CALL partition_maintenance_all()\";
    EOH
    action :run
  end
end

partition_cron = node['zabbix']['partition_database']['cron_schedule'].split(' ')

# Cron job to run partition_maintenance_all

cron 'create_zabbix_partitions' do
  minute partition_cron[0]
  hour partition_cron[1]
  day partition_cron[2]
  month partition_cron[3]
  weekday partition_cron[4]
  command "mysql #{node['zabbix']['server']['conf']['DBName']} -e \"CALL partition_maintenance_all();\""
  if node['zabbix']['partition_database']['perform_partition']
    action :create
  else
    action :delete
  end
end
