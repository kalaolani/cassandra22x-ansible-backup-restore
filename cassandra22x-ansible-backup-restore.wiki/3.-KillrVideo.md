### Test keyspace is KillrVideo
https://killrvideo.github.io/

Since I did not use their setup, I simple lifted out the schema and data and loaded that up into the keyspace on my cassandra cluster. Thanks Datastax for putting together for us. And, thanks to Patrick McFadin and others at Datastax for the free training videos. I mention Patrick by name only because he is the reason I found out about killrvideo.

This is the "footprint" or the scale of the cassandra data that I'm dealing with in this development test environment.
```
[root@ansible ~]# ansible cassandra -m shell -a "du -sh /var/lib/cassandra/data"
cass2.deltakappa.com | CHANGED | rc=0 >>
115M    /var/lib/cassandra/data
cass3.deltakappa.com | CHANGED | rc=0 >>
114M    /var/lib/cassandra/data
cass1.deltakappa.com | CHANGED | rc=0 >>
105M    /var/lib/cassandra/data
```
More on the test "footprint" or the scale of the cassandra data and nfs archive data that I'm dealing with in this development test environment.
```
[root@ansible ansible]# ansible cluster22 -m shell -a "du -sh /var/lib/cassandra/data"
cass2.deltakappa.com | CHANGED | rc=0 >>
120M    /var/lib/cassandra/data

cass3.deltakappa.com | CHANGED | rc=0 >>
117M    /var/lib/cassandra/data

cass1.deltakappa.com | CHANGED | rc=0 >>
108M    /var/lib/cassandra/data

[root@ansible ansible]# ansible cluster22 -m shell -a "du -sh /var/nfsshare"
cass2.deltakappa.com | CHANGED | rc=0 >>
324M    /var/nfsshare

cass3.deltakappa.com | CHANGED | rc=0 >>
358M    /var/nfsshare

cass1.deltakappa.com | CHANGED | rc=0 >>
350M    /var/nfsshare
```



