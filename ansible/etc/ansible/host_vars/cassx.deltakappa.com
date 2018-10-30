---
# nfs server
cassandra22x_nfs_server: sstableloader.deltakappa.com
cassandra22x_nfs_server_path: /var/nfsshare/
cassandra22x_nfs_client_mount: "/mnt/nfs/{{ cassandra22x_nfs_server }}/var/nfsshare"

## restore variables
# dest cluster node that will deploy schema
# cassandra22x_dest_cluster_node_schema: cassx.deltakappa.com
# src cluster node supplying schema
# cassandra22x_src_cluster_node_schema: cass10.deltakappa.com

# sstableloader
cassandra22x_sstableloader_node: sstableloader.deltakappa.com

# src node to dest node map dictionary
cassandra22x_src_cluster_node_map_dict:
   - cassandra22x_node1:
       cassandra22x_src_cluster_node: cass10.deltakappa.com
       cassandra22x_src_cluster_nfs_server: cass20.deltakappa.com
   - cassandra22x_node2:
       cassandra22x_src_cluster_node: cass20.deltakappa.com
       cassandra22x_src_cluster_nfs_server: cass30.deltakappa.com
   - cassandra22x_node3:
       cassandra22x_src_cluster_node: cass30.deltakappa.com
       cassandra22x_src_cluster_nfs_server: cass10.deltakappa.com