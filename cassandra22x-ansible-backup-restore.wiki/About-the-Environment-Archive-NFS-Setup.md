##### nfs servers for off node archiving of snapshots
install and configure nfs using a horitzonal deployment equal to your nodes...

| cassandra source | nfs archive server |
| --- | --- |
| cass1.deltakappa.com | cass2.deltakappa.com |
| cass2.deltakappa.com | cass3.deltakappa.com |
| cass3.deltakappa.com | cass1.deltakappa.com |

###### install nfs
```
[root@ansible ansible]# ansible cluster22 -m shell -a "yum -y install nfs-utils"
[root@ansible ansible]# ansible cluster22 -m shell -a "systemctl enable rpcbind"
[root@ansible ansible]# ansible cluster22 -m shell -a "systemctl enable nfs-server"
[root@ansible ansible]# ansible cluster22 -m shell -a "systemctl enable nfs-lock"
[root@ansible ansible]# ansible cluster22 -m shell -a "systemctl enable nfs-idmap"
[root@ansible ansible]# ansible cluster22 -m shell -a "systemctl start rpcbind"
[root@ansible ansible]# ansible cluster22 -m shell -a "systemctl start nfs-server"
[root@ansible ansible]# ansible cluster22 -m shell -a "systemctl start nfs-lock"
[root@ansible ansible]# ansible cluster22 -m shell -a "systemctl start nfs-idmap"
```

###### configure nfs
for the sample environment /etc/exports contains the following config on each nfs server
```
/var/nfsshare/{{ cassandra22x_nfs_server }}    10.10.10.*(rw,sync,no_root_squash,no_all_squash)
```
replace {{ cassandra22x_nfs_server }} with the appropriate nfs archive server's host_name 

and then use ansible to create paths and mount the nfs servers
```
[root@ansible ansible]# ansible cluster22 -m shell -a "mkdir -p {{ cassandra22x_nfs_server_mount }}"
[root@ansible ansible]# ansible cluster22 -m shell -a "mount -t nfs {{ cassandra22x_nfs_server }}:{{ cassandra22x_nfs_server_path }} {{ cassandra22x_nfs_client_mount }}"
```

###### wipe file servers of all cassandra archives using ansible
```
ansible cluster22 -m shell -a" rm -fR {{ cassandra22x_remote_archive_path }}/*"
```