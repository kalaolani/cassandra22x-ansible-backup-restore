#!/usr/bin/python

### Descriptioin: get_columnfamilies_ondisk_for_keyspace.py python script for the cass_snapshot role
### Author: David Payne
### command line example: ./get_columnfamilies_ondisk_for_keyspace.py -k production -c clxcasst1.chicago.cqg,clxcasst2.chicago.cqg,clxcasst3.chicago.cqg,dlxcasst4.denver.cqg,dlxcasst5.denver.cqg -u username -p password
### outputs a list of column family names on disk for a keyspace
### the location on disk is always the schema_columnfamilies.columnfamily_name + "-" + schema_columnfamilies.cf_id without the "-" in the cf_id UUID

import sys
import getopt
import cassandra
from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider

def main(argv):
    contact_points = ''
    username = ''
    password = ''
    connect_timeout = 30
    try:
        opts, args = getopt.getopt(argv,"hk:c:u:p:",["keyspace_name=","contact_points=","username=","password="])
    except getopt.GetoptError:
        print 'get_columnfamilies_ondisk_for_keyspace.py -k <keyspace_name> -c <contact_points> -u <username> -p <password>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'get_columnfamilies_ondisk_for_keyspace.py -k <keyspace_name> -c <contact_points> -u <username> -p <password>'
            sys.exit()
        elif opt in ("-k", "--keyspace_name"):
            keyspace_name = arg
        elif opt in ("-c", "--contact_points"):
            contact_points = arg.split(",")
        elif opt in ("-u", "--username"):
            username = arg
        elif opt in ("-p", "--password"):
            password = arg
            
    auth_provider = PlainTextAuthProvider(username=username, password=password)
    cluster = Cluster(contact_points=contact_points, control_connection_timeout=connect_timeout, auth_provider=auth_provider)
    session = cluster.connect('system')
    query = 'SELECT columnfamily_name, cf_id FROM schema_columnfamilies WHERE keyspace_name=%s'
    rows = session.execute(query, [keyspace_name])
    for row in rows:
        print "    - " + row.columnfamily_name + "-" + str(row.cf_id).replace("-","")

if __name__ == "__main__":
    main(sys.argv[1:])
