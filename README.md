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
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
