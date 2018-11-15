Using ad hoc Ansible commands to add other dependencies

##### python-setuptools, python-pip, and the cassandra-driver
install the python-setuptools, python-pip, the cassandra-driver on each cassandra node
- /usr/lib64/python2.7/site-packages (3.15.1)
- /usr/lib/python2.7/site-packages (from cassandra-driver) (1.11.0)
- /usr/lib/python2.7/site-packages (from cassandra-driver) (3.2.0)

```
[root@ansible ~]# ansible cass1.deltakappa.com -m shell -a "yum -y install python-setuptools"
[root@ansible ~]# ansible cass1.deltakappa.com -m shell -a "yum -y install python-pip"
[root@ansible ~]# ansible cass1.deltakappa.com -m shell -a "pip install --upgrade pip"
[root@ansible ~]# ansible cass1.deltakappa.com -m shell -a "pip install cassandra-driver"
```