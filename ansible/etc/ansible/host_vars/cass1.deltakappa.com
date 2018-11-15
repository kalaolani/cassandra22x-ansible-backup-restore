---
# nfs server
cassandra22x_nfs_server: cass2.deltakappa.com
cassandra22x_nfs_server_path: /var/nfsshare/
cassandra22x_nfs_client_mount: "/mnt/nfs/{{ cassandra22x_nfs_server }}/var/nfsshare"