---
# nfs server
cassandra22x_nfs_server: cass5.deltakappa.com
cassandra22x_nfs_server_path: /var/nfsshare/
cassandra22x_nfs_client_mount: "/mnt/nfs/{{ cassandra22x_nfs_server }}/var/nfsshare"

## restore variables
# src node to dest without node map dictionary
cassandra22x_src_cluster_node: cass4.deltakappa.com
cassandra22x_src_cluster_nfs_server: cass5.deltakappa.com
