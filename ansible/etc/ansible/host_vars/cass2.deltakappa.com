---
## restore variables local (dest) cluster
# sample host_vars for the sample cass1.deltakappa.com cassandra node
cassandra22x_nfs_server: cass3.deltakappa.com
cassandra22x_nfs_server_path: /var/nfsshare/
cassandra22x_nfs_client_mount: "/mnt/nfs/{{ cassandra22x_nfs_server }}/var/nfsshare"

## restore variables foreign (src) cluster
# restore variables src cluster
cassandra22x_src_cluster_node: cass20.deltakappa.com
cassandra22x_src_cluster_nfs_server: cass30.deltakappa.com
cassandra22x_src_cluster_nfs_server_path: /var/nfsshare/
cassandra22x_src_cluster_nfs_client_mount: "/mnt/nfs/{{ cassandra22x_src_cluster_nfs_server }}/var/nfsshare"