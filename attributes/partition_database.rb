# coding: UTF-8

default['zabbix']['partition_database']['tables'] = {
  history: { days_to_keep_data: 30, hourly_interval: 24, num_future_intervals_to_create: 15 },
  history_log: { days_to_keep_data: 30, hourly_interval: 24, num_future_intervals_to_create: 15 },
  history_str: { days_to_keep_data: 30, hourly_interval: 24, num_future_intervals_to_create: 15 },
  history_text: { days_to_keep_data: 30, hourly_interval: 24, num_future_intervals_to_create: 15 },
  history_uint: { days_to_keep_data: 30, hourly_interval: 24, num_future_intervals_to_create: 15 },
  trends: { days_to_keep_data: 365, hourly_interval: 24, num_future_intervals_to_create: 15 },
  trends_uint: { days_to_keep_data: 364, hourly_interval: 24, num_future_intervals_to_create: 15 }
}

default['zabbix']['partition_database']['cron_schedule'] = '0 13 * * *'
default['zabbix']['partition_database']['perform_partition'] = false
