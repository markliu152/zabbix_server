#Table Of Contents:#
* [Description](#description)
* [Requirements](#requirements)
    * [System](#system)
    * [Cookbook-Dependancies](#cookbook-dependancies)
    * [Known Incompatibility](#Known-Incompatibility)
* [Attributes](#attributes)
    * [Zabbix-Server](#zabbix-server)
    * [Zabbix-Proxy](#zabbix-proxy)
    * [Maria](#maria)
    * [Partitioning tables](#partitioning-tables)
* [Usage](#usage)
    * [Recipes](#databags)
    * [DataBags](#databags)
    * [Roles](#roles)
* [Development](#development)
    * [Contributing](#contributing)

## Description ##

This cookbook is used to installed Zabbix Server and Zabbix Proxy version 3.x. 

## Requirements ##

### System ###
- Chef 16+
- RHEL/CentOS 7

### Cookbook-Dependancies ###
This cookbook directly depends on the following cookbooks (these cookbooks have their own attributes and dependancies that will also have to be accounted for):

* [yum][]
* [yum-epel][]
* [java][]
* [apache2][]

### Known Incompatibility ###

## Attributes ##

Default attributes that are intially set to an empty string are intended to be overridden. These values can be overridden in the roles that configure the primary components: proxy and server.

### General Attributes ###

Attributes that need to be overridden:

* `default['zabbix']['install_type'] = ''` # server or proxy, based on what you want to install.
* `default['zabbix']['server']['conf']['ListenIP'] = ''` # IP for zabbix server to listen on, you can set or it will be set automatically to node['ipaddress'] from ohai.

### Zabbix-Server ###

zabbix_server.conf attributes that need to be overriden:

* `default['zabbix']['server']['conf']['DBUser'] = ''`

### Zabbix-Proxy ###

zabbix_proxy.conf attributes that needs to be overriden:

* `default['zabbix']['proxy']['conf']['Hostname'] = ''`
* `default['zabbix']['proxy']['conf']['DBUser'] = ''`

### Maria ###
* `default['mariadb']['package_list']` # an array of packages to install
* `default['mariadb']['uninstall_package_list']` # an array of packages to uninstall
* `default['mysql']['upgrade']` # only set it to true when upgrading Mysql/Mariadb
* `default['mysql']['mount_bin_dir']` # Location to store bin logs Default: /var/lib/mysql but you can override this.
* `default['mysql']['mount_backup_dir']` # Location to store mysql backups Default: /var/lib/mysql but you can override this.
* `default['mysql']['dev_backup_mounts']` # Creates a vg and lv to store backups. Default: empty. You can provide /dev/ locations to enable this function. Also mount_backup_dir must be different from mount_data_dir. 

### Partitioning tables ###
* `default['zabbix']['partition_database']['perform_partition'] = true` # If true, the specified zabbix database tables will be parititoned.
* `default['zabbix']['partition_database']['tables'] = {
  history: {days_to_keep_data: 28, hourly_interval: 24, num_future_intervals_to_create: 14},
  history_log: {days_to_keep_data: 28, hourly_interval: 24, num_future_intervals_to_create: 14},
  history_str: {days_to_keep_data: 28, hourly_interval: 24, num_future_intervals_to_create: 14},
  history_text: {days_to_keep_data: 28, hourly_interval: 24, num_future_intervals_to_create: 14},
  history_uint: {days_to_keep_data: 28, hourly_interval: 24, num_future_intervals_to_create: 14},
  trends: {days_to_keep_data: 730, hourly_interval: 24, num_future_intervals_to_create: 14},
  trends_uint: {days_to_keep_data: 730, hourly_interval: 24, num_future_intervals_to_create: 14}
}` # A hash of zabbix tables to partition, each of which points to a hash of: number of days to keep the data(days_to_keep_data), partition intervals(hourly_interval) and the number of future partition intervals to create(num_future_intervals_to_create).
* `default['zabbix']['partition_database']['cron_schedule'] = '0 13 * * *'` # Cron job to run the partition_maintenance_all SQL procedure, which creates partitions if it does not exist and drops old partitions.

## Usage ##

### Recipes ###

The intended usage of this cookbook relies on roles to call the recipes for each portion of the Zabbix configuration. As such, the default recipe is blank.

* zabbix_proxy - Installs and configures zabbix proxy.
* zabbix_server - Installs and configures zabbix server.
* openid - Installs and configures support for openid in zabbix server.
* php - Installs and configures php 5.4 (packages from webtatic)
* mysql - Installs and configures MariaDB 5.5 along with galera

The cookbook sets up four yum repositories.

* mariaDB repo
* webtatic repo
* zabbix repo
* epel repo

The default attributes used for setting up the yum repos have been tested. Overriding any of these attributes is not recommended with out extensive testing first.
* * *
By default the yum-epel::default recipe is used. In the event that a specific epel repository is needed, the baseurl can be sepcified and the mirrorlist can be disabled by overriding the epel attributes. For example (in a role):
```
override_attributes "yum" => {
  "epel" => {
    "mirrorlist" => false,
    "baseurl" => "http://mirrors.example.org/example/x86_64/"
  }
}
```
* * *

#### PHP ####

When using the php mysql_connect function, we get the following error.

```
'mysql_connect(): Headers and client library minor version mismatch. Headers:50156 Library:50206'
```

This is because the library checks and expects that the client library must be the exact same version as PHP was compiled with. The check is not crucial and does not break anything. The suggested solution is to run with a lower error reporting level. In db.inc.php which calls mysql_connect function, the error reporting level has been reduced.

### DataBags ###

The default attribute name for the zabbix databag is set by: "node['zabbix']['data_bag_name']".  The default value for the zabbix databag is: 'zabbix'. An example of the databage structure is as follows (please note that acutual password values should be substituted):
```
{
"id" : "passwords" ,
"mysql_root_password" : "exmaplepass1" ,
"mysql_user_password" : "example_user",
"mysql_repl_password" : "exmaplepass2",
"keepalived_auth_pass": "super_secret_example",
"web_ui_password": "exmaplepass_ui",
"ldap_bind_password": "example_bind_password"
}
```

[yum]: https://github.com/opscode-cookbooks/yum
[yum-epel]: https://github.com/opscode-cookbooks/yum-epel
[java]: https://github.com/opscode-cookbooks/java
[apache2]: https://github.com/svanzoest-cookbooks/apache2/
