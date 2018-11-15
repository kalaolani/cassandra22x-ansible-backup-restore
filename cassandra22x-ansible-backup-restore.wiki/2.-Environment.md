### Software Versions
- Linux - CentOS Linux release 7.5.1804 (Core) w/ minimal, dev tools, compatibility
  - https://www.centos.org/
- Ansible - ansible 2.7.0
  - https://www.ansible.com/    
  - Newbie How To? ansible --version
- Java - openjdk version "1.8.0_181"
  - https://openjdk.java.net/
- Cassandra - 2.2.13
  - http://cassandra.apache.org/

### About Repos Used
other (not part of default CentOS 7 install) repos configured on all systems of the sample environment
- cassandra.repo - http://cassandra.apache.org/doc/4.0/getting_started/installing.html
- epel.repo - https://fedoraproject.org/wiki/EPEL
  
### Ansible and Cassandra Node HW
Nothing special ...  1 CPU, 1GB RAM, 20GB Disk per VM all running on an average developer/ops type workstation with a i7-2600K@3.4GHz CPU, 16GB of RAM, RAID-10 SSDs for host OS and developer/ops data, and SATA spinning rust x2 for all VMs with a deployment like this ... ansible cass2 spinning rust 1 | cass 1 cass 3 spinning rust 2 ... so, you can see the type of imbalance that I expect to see in terms of ansible output. The host OS is good old Windows 7 using Oracle Virtual Box for the VMs. Cassandra configuration is all defaults. The only alertaions to any config file was to configure the clusters's minimal settings that include remote networking.

### The Cassandra Cluster
The cluster from an ad hoc Ansible every node (overkill) POV (point of view)...
- <p><code>[root@ansible ~]# ansible cluster22 -a"nodetool info"</code></p>
- <p><code>[root@ansible ~]# ansible cluster22 -a"nodetool status"</code></p>
- <p><code>[root@ansible ~]# ansible cluster22 -a"nodetool describecluster"</code></p>
- nodetool documentation
  - nodetool - https://docs.datastax.com/en/archived/cassandra/2.1/cassandra/tools/toolsNodetool_r.html
  - easiest to use good enough docs ^
  - http://cassandra.apache.org/doc/4.0/tools/nodetool/nodetool.html
  - official docs ... meh ... ^

#### nodetool info
```
ansible cluster22 -a"nodetool info"

cass2.deltakappa.com | CHANGED | rc=0 >>
ID                     : fbf6aa22-51af-4b79-867f-77d4524d9efa
Gossip active          : true
Thrift active          : false
Native Transport active: true
Load                   : 113.73 MB
Generation No          : 1539965741
Uptime (seconds)       : 15402
Heap Memory (MB)       : 121.97 / 486.00
Off Heap Memory (MB)   : 0.17
Data Center            : deltakappa
Rack                   : rack1
Exceptions             : 0
Key Cache              : entries 40, size 3.6 KB, capacity 24 MB, 167 hits, 208 requests, 0.803 recent hit rate, 14400 save period in seconds
Row Cache              : entries 0, size 0 bytes, capacity 0 bytes, 0 hits, 0 requests, NaN recent hit rate, 0 save period in seconds
Counter Cache          : entries 2, size 248 bytes, capacity 12 MB, 0 hits, 0 requests, NaN recent hit rate, 7200 save period in seconds
Token                  : (invoke with -T/--tokens to see all 256 tokens)

cass3.deltakappa.com | CHANGED | rc=0 >>
ID                     : 0222aa0b-a9d0-41cb-8fce-0b0b94d17ba8
Gossip active          : true
Thrift active          : false
Native Transport active: true
Load                   : 111.31 MB
Generation No          : 1539965809
Uptime (seconds)       : 15375
Heap Memory (MB)       : 113.43 / 486.00
Off Heap Memory (MB)   : 0.20
Data Center            : deltakappa
Rack                   : rack1
Exceptions             : 0
Key Cache              : entries 49, size 6.84 KB, capacity 24 MB, 163 hits, 225 requests, 0.724 recent hit rate, 14400 save period in seconds
Row Cache              : entries 0, size 0 bytes, capacity 0 bytes, 0 hits, 0 requests, NaN recent hit rate, 0 save period in seconds
Counter Cache          : entries 0, size 0 bytes, capacity 12 MB, 0 hits, 0 requests, NaN recent hit rate, 7200 save period in seconds
Token                  : (invoke with -T/--tokens to see all 256 tokens)

cass1.deltakappa.com | CHANGED | rc=0 >>
ID                     : a6d9f51e-e665-4062-9063-c0f62a5cd7ed
Gossip active          : true
Thrift active          : false
Native Transport active: true
Load                   : 103.14 MB
Generation No          : 1539965669
Uptime (seconds)       : 15504
Heap Memory (MB)       : 258.73 / 486.00
Off Heap Memory (MB)   : 0.17
Data Center            : deltakappa
Rack                   : rack1
Exceptions             : 0
Key Cache              : entries 46, size 4.15 KB, capacity 24 MB, 174 hits, 239 requests, 0.728 recent hit rate, 14400 save period in seconds
Row Cache              : entries 0, size 0 bytes, capacity 0 bytes, 0 hits, 0 requests, NaN recent hit rate, 0 save period in seconds
Counter Cache          : entries 2, size 248 bytes, capacity 12 MB, 0 hits, 0 requests, NaN recent hit rate, 7200 save period in seconds
Token                  : (invoke with -T/--tokens to see all 256 tokens)
```
#### nodetool status
```
ansible cluster22 -a"nodetool status" output

cass2.deltakappa.com | CHANGED | rc=0 >>
Datacenter: deltakappa
======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address      Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.10.10.51  103.14 MB  256          100.0%            a6d9f51e-e665-4062-9063-c0f62a5cd7ed  rack1
UN  10.10.10.52  113.73 MB  256          100.0%            fbf6aa22-51af-4b79-867f-77d4524d9efa  rack1
UN  10.10.10.53  111.31 MB  256          100.0%            0222aa0b-a9d0-41cb-8fce-0b0b94d17ba8  rack1

cass3.deltakappa.com | CHANGED | rc=0 >>
Datacenter: deltakappa
======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address      Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.10.10.51  103.14 MB  256          100.0%            a6d9f51e-e665-4062-9063-c0f62a5cd7ed  rack1
UN  10.10.10.52  113.73 MB  256          100.0%            fbf6aa22-51af-4b79-867f-77d4524d9efa  rack1
UN  10.10.10.53  111.31 MB  256          100.0%            0222aa0b-a9d0-41cb-8fce-0b0b94d17ba8  rack1

cass1.deltakappa.com | CHANGED | rc=0 >>
Datacenter: deltakappa
======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address      Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.10.10.51  103.14 MB  256          100.0%            a6d9f51e-e665-4062-9063-c0f62a5cd7ed  rack1
UN  10.10.10.52  113.73 MB  256          100.0%            fbf6aa22-51af-4b79-867f-77d4524d9efa  rack1
UN  10.10.10.53  111.31 MB  256          100.0%            0222aa0b-a9d0-41cb-8fce-0b0b94d17ba8  rack1
```
#### nodetool describecluster
```
ansible cluster22 -a"nodetool describecluster"

cass2.deltakappa.com | CHANGED | rc=0 >>
Cluster Information:
        Name: cluster22
        Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
        Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
        Schema versions:
                3adce62d-808d-3f1a-ad24-e23220170631: [10.10.10.51, 10.10.10.52, 10.10.10.53]

cass3.deltakappa.com | CHANGED | rc=0 >>
Cluster Information:
        Name: cluster22
        Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
        Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
        Schema versions:
                3adce62d-808d-3f1a-ad24-e23220170631: [10.10.10.51, 10.10.10.52, 10.10.10.53]

cass1.deltakappa.com | CHANGED | rc=0 >>
Cluster Information:
        Name: cluster22
        Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
        Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
        Schema versions:
                3adce62d-808d-3f1a-ad24-e23220170631: [10.10.10.51, 10.10.10.52, 10.10.10.53]
```

### Ad hoc Environment Notes...
auto_snapshot is enabled by default & disabling auto_snapshot
Disabling auto_snapshot to avoid dealing with automatically create snapshots on truncation of tables.

```
root@ansible ansible]# ansible cluster22 -m shell -a" grep auto_snapshot {{ cassandra22x_yaml }}"
cass2.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: true
# (This can be much longer, because unless auto_snapshot is disabled

cass1.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: true
# (This can be much longer, because unless auto_snapshot is disabled

cass3.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: true
# (This can be much longer, because unless auto_snapshot is disabled

[root@ansible ansible]# ansible cluster22 -m shell -a"sed -i 's/auto_snapshot\: true/auto_snapshot\: false/g' {{ cassandra22x_yaml }}"
cass1.deltakappa.com | CHANGED | rc=0 >>
cass2.deltakappa.com | CHANGED | rc=0 >>
cass3.deltakappa.com | CHANGED | rc=0 >>


[root@ansible ansible]# ansible cluster22 -m shell -a" grep auto_snapshot {{ cassandra22x_yaml }}"
cass1.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: false
# (This can be much longer, because unless auto_snapshot is disabled

cass2.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: false
# (This can be much longer, because unless auto_snapshot is disabled

cass3.deltakappa.com | CHANGED | rc=0 >>
auto_snapshot: false
# (This can be much longer, because unless auto_snapshot is disabled

[root@ansible ansible]# ansible-playbook playbooks/cluster22/cassandra22x_operate_rolling_restart.yml
```

### Diagram

![](https://github.com/kalaolani/cassandra22x-ansible-backup-restore/blob/master/SampleEnv.jpg)

#### Notes on using cluster22 to create cluster220
create the following environment where you can switch between cluster22 and cluster220
or run both cluster22 and cluster220

##### cluster22 

| nfs server nodes:path | cass node archive? |
| --- | --- |
| cass1.deltakappa.com:/var/nfsshare | (archive for cass3) |
| cass2.deltakappa.com:/var/nfsshare | (archive for cass1) |
| cass3.deltakappa.com:/var/nfsshare | (archive for cass2) |

| cassandra cluster22 nodes | nfs client |
| --- | --- |
| cass1.deltakappa.com | /mnt/nfs/cass2.deltakappa.com/var/nfsshare on cass2.deltakappa.com:/var/nfsshare |
| cass2.deltakappa.com | /mnt/nfs/cass3.deltakappa.com/var/nfsshare on cass3.deltakappa.com:/var/nfsshare |
| cass3.deltakappa.com | /mnt/nfs/cass1.deltakappa.com/var/nfsshare on cass1.deltakappa.com:/var/nfsshare |

##### cluster220

| nfs server nodes:path | cass node archive? |
| --- | --- |
| cass10.deltakappa.com:/var/nfsshare | (archive for cass30) |
| cass20.deltakappa.com:/var/nfsshare | (archive for cass10) |
| cass30.deltakappa.com:/var/nfsshare | (archive for cass20) |

| cassandra cluster220 nodes | nfs client |
| --- | --- |
| cass10.deltakappa.com | /mnt/nfs/cass20.deltakappa.com/var/nfsshare on cass20.deltakappa.com:/var/nfsshare |
| cass20.deltakappa.com | /mnt/nfs/cass30.deltakappa.com/var/nfsshare on cass30.deltakappa.com:/var/nfsshare |
| cass30.deltakappa.com | /mnt/nfs/cass10.deltakappa.com/var/nfsshare on cass10.deltakappa.com:/var/nfsshare |

##### ansible

| ansible.deltakappa.com | nfs client |
| --- | --- |
| | /mnt/nfs/cass2.deltakappa.com/var/nfsshare on cass2.deltakappa.com:/var/nfsshare |
| | /mnt/nfs/cass3.deltakappa.com/var/nfsshare on cass3.deltakappa.com:/var/nfsshare |
| | /mnt/nfs/cass1.deltakappa.com/var/nfsshare on cass1.deltakappa.com:/var/nfsshare |
| | /mnt/nfs/cass20.deltakappa.com/var/nfsshare on cass20.deltakappa.com:/var/nfsshare |
| | /mnt/nfs/cass30.deltakappa.com/var/nfsshare on cass30.deltakappa.com:/var/nfsshare |
| | /mnt/nfs/cass10.deltakappa.com/var/nfsshare on cass10.deltakappa.com:/var/nfsshare |

Create the cluster220 cluster from the cluster22 cluster.
1. copy the cluster22 VMs to cass10, cass20, cass30
2. disable cassandra, reconfigure networking, and reboot
3. configure ssh keys until the following is working

```
[root@ansible ansible]# ansible cluster2200 -m ping
cass20.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
cass30.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
cass10.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
```

4. reconfigure cassandra nodes for the cluster220 cluster

a. change the cluster_name

```
ansible cluster220 -m shell -a"grep cluster_name {{ cassandra22x_yaml }}"

cass10.deltakappa.com | CHANGED | rc=0 >>
cluster_name: 'cluster22'

cass20.deltakappa.com | CHANGED | rc=0 >>
cluster_name: 'cluster22'

cass30.deltakappa.com | CHANGED | rc=0 >>
cluster_name: 'cluster22'

ansible cluster220 -m shell -a"sed -i 's/cluster22/cluster220/g' {{ cassandra22x_yaml }}"

cass20.deltakappa.com | CHANGED | rc=0 >>
cass10.deltakappa.com | CHANGED | rc=0 >>
cass30.deltakappa.com | CHANGED | rc=0 >>

ansible cluster220 -m shell -a"grep cluster_name {{ cassandra22x_yaml }}"
cass20.deltakappa.com | CHANGED | rc=0 >>
cluster_name: 'cluster220'

cass30.deltakappa.com | CHANGED | rc=0 >>
cluster_name: 'cluster220'

cass10.deltakappa.com | CHANGED | rc=0 >>
cluster_name: 'cluster220'
```

b. change the seed nodes

```
ansible cluster220 -m shell -a"grep seeds\: {{ cassandra22x_yaml }}"

cass20.deltakappa.com | CHANGED | rc=0 >>
          - seeds: "cass1.deltakappa.com,cass2.deltakappa.com,cass3.deltakappa.com"

cass10.deltakappa.com | CHANGED | rc=0 >>
          - seeds: "cass1.deltakappa.com,cass2.deltakappa.com,cass3.deltakappa.com"

cass30.deltakappa.com | CHANGED | rc=0 >>
          - seeds: "cass1.deltakappa.com,cass2.deltakappa.com,cass3.deltakappa.com"

ansible cluster220 -m shell -a"sed -i 's/cass1.deltakappa.com,cass2.deltakappa.com,cass3.deltakappa.com/cass10.deltakappa.com,cass20.deltakappa.com,cass30.deltakappa.com/g' {{ cassandra22x_yaml }}"

cass20.deltakappa.com | CHANGED | rc=0 >>
cass30.deltakappa.com | CHANGED | rc=0 >>
cass10.deltakappa.com | CHANGED | rc=0 >>


nsible cluster220 -m shell -a"grep seeds\: {{ cassandra22x_yaml }}"

cass20.deltakappa.com | CHANGED | rc=0 >>
          - seeds: "cass10.deltakappa.com,cass20.deltakappa.com,cass30.deltakappa.com"

cass10.deltakappa.com | CHANGED | rc=0 >>
          - seeds: "cass10.deltakappa.com,cass20.deltakappa.com,cass30.deltakappa.com"

cass30.deltakappa.com | CHANGED | rc=0 >>
          - seeds: "cass10.deltakappa.com,cass20.deltakappa.com,cass30.deltakappa.com"
```

c. change the listen & rpc addresses

```
ansible cluster220 -m shell -a"grep listen_address\:cass {{ cassandra22x_yaml }}"
ansible cluster220 -m shell -a"grep rpc_address\:cass {{ cassandra22x_yaml }}"

ansible cluster220 -m shell -a"sed -i 's/cass1.deltakappa.com/cass10.deltakappa.com/g' {{ cassandra22x_yaml }}"
ansible cluster220 -m shell -a"sed -i 's/cass2.deltakappa.com/cass20.deltakappa.com/g' {{ cassandra22x_yaml }}"
ansible cluster220 -m shell -a"sed -i 's/cass3.deltakappa.com/cass30.deltakappa.com/g' {{ cassandra22x_yaml }}"

ansible cluster220 -m shell -a"grep 'listen_address\: cass' {{ cassandra22x_yaml }}"
ansible cluster220 -m shell -a"grep 'rpc_address\: cass' {{ cassandra22x_yaml }}"
```

d. reset the node log, commit log, cache, and data

```
ansible cluster220-m shell -a"rm -fR {{ cassandra22x_var_path }}/archive/*"
ansible cluster220-m shell -a"rm -f {{ cassandra22x_var_path }}/commitlog/*"
ansible cluster220 -m shell -a"rm -f {{ cassandra22x_var_path }}/saved_caches/*"
ansible cluster220-m shell -a"rm -f {{ cassandra22x_log_path }}/*"
ansible cluster220-m shell -a"rm -fR {{ cassandra22x_data_path }}/*"
```

e. enable, start, and check the cassandra cluster cluster220 

```
enable cassandra and start
ansible cluster220 -m shell -a"systemctl enable cassandra"
ansible cluster220-m shell -a"systemctl start cassandra"
```

```
ansible cluster220-m shell -a"nodetool status"
cass30.deltakappa.com | CHANGED | rc=0 >>
Datacenter: deltakappa
======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address      Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.10.10.56  97.16 KB   256          68.1%             844372ff-70ba-49b3-a95b-e61b3ceac0ea  rack1
UN  10.10.10.57  102.2 KB   256          62.9%             d8d043e2-dec2-4fa8-81ac-ce54a8965379  rack1
UN  10.10.10.55  115.37 KB  256          69.1%             285a5a60-2875-42e8-ac62-6f71cabb8268  rack1

cass20.deltakappa.com | CHANGED | rc=0 >>
Datacenter: deltakappa
======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address      Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.10.10.56  102.26 KB  256          68.1%             844372ff-70ba-49b3-a95b-e61b3ceac0ea  rack1
UN  10.10.10.57  88.22 KB   256          62.9%             d8d043e2-dec2-4fa8-81ac-ce54a8965379  rack1
UN  10.10.10.55  115.37 KB  256          69.1%             285a5a60-2875-42e8-ac62-6f71cabb8268  rack1

cass10.deltakappa.com | CHANGED | rc=0 >>
Datacenter: deltakappa
======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address      Load       Tokens       Owns (effective)  Host ID                               Rack
UN  10.10.10.56  97.16 KB   256          68.1%             844372ff-70ba-49b3-a95b-e61b3ceac0ea  rack1
UN  10.10.10.57  88.22 KB   256          62.9%             d8d043e2-dec2-4fa8-81ac-ce54a8965379  rack1
UN  10.10.10.55  67.76 KB   256          69.1%             285a5a60-2875-42e8-ac62-6f71cabb8268  rack1

ansible cluster220-m shell -a"nodetool describecluster"
cass20.deltakappa.com | CHANGED | rc=0 >>
Cluster Information:
        Name: cluster220
        Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
        Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
        Schema versions:
                b145475a-02dc-370c-8af7-a9aba2d61362: [10.10.10.56, 10.10.10.57, 10.10.10.55]

cass30.deltakappa.com | CHANGED | rc=0 >>
Cluster Information:
        Name: cluster220
        Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
        Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
        Schema versions:
                b145475a-02dc-370c-8af7-a9aba2d61362: [10.10.10.56, 10.10.10.57, 10.10.10.55]

cass10.deltakappa.com | CHANGED | rc=0 >>
Cluster Information:
        Name: cluster220
        Snitch: org.apache.cassandra.locator.DynamicEndpointSnitch
        Partitioner: org.apache.cassandra.dht.Murmur3Partitioner
        Schema versions:
                b145475a-02dc-370c-8af7-a9aba2d61362: [10.10.10.56, 10.10.10.57, 10.10.10.55]
```

**cluster220is now ready to go!**
