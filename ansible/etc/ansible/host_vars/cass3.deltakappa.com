---
## restore variables local (dest) cluster
# sample host_vars for the sample cass1.deltakappa.com cassandra node
cassandra22x_nfs_server: cass1.deltakappa.com
cassandra22x_nfs_server_path: /var/nfsshare/
cassandra22x_nfs_client_mount: "/mnt/nfs/{{ cassandra22x_nfs_server }}/var/nfsshare"

## restore variables foreign (src) cluster
# restore variables src cluster
cassandra22x_src_node: cass30.deltakappa.com
cassandra22x_src_nfs_server: cass10.deltakappa.com
cassandra22x_src_nfs_server_path: /var/nfsshare/
cassandra22x_src_nfs_client_mount: "/mnt/nfs/{{ cassandra22x_src_nfs_server }}/var/nfsshare"