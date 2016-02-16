zabbix Cookbook
===============
This cookbook is to install zabbix-server 3.0 LTS and zabbix-agent LTS on RHEL 7. Using MariaDB (Mysql) database.

Requirements
------------
#### Platform
OS Platform: RHEL/CentOS 7

Attributes
----------
#### zabbix::server
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['zabbix']['server']['enabled']</tt></td>
    <td>Boolean</td>
    <td>Will install zabbix server if true</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['zabbix']['server']['conf']['DBPassword']</tt></td>
    <td>Text</td>
    <td>DB password located in the zabbix-server.conf file</td>
    <td><tt>empty</tt></td>
  </tr>
  <tr>
    <td><tt>['zabbix']['php']['timezone']</tt></td>
    <td>Text</td>
    <td>Set your local timezone here</td>
    <td><tt>Europe/Riga</tt></td>
  </tr>
</table>

#### zabbix::mariadb
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['zabbix']['mysql']['root_password']</tt></td>
    <td>Text</td>
    <td>Root DB password</td>
    <td><tt>empty</tt></td>
  </tr>
</table>

#### zabbix::agent
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['zabbix']['agent']['enabled']</tt></td>
    <td>Boolean</td>
    <td>Will install zabbix agent if true</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['zabbix']['agent']['Server']</tt></td>
    <td>Text</td>
    <td>Sets the Server setting in zabbix-agentd.conf</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['zabbix']['agent']['ServerActive']</tt></td>
    <td>Text</td>
    <td>Sets the ServerActive setting in zabbix-agentd.conf</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
</table>

Usage
-----
#### zabbix::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `zabbix` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[zabbix]"
  ]
}
```

Contributing
------------
Not open to contribution at this time.

License and Authors
-------------------
Authors: Som3guy