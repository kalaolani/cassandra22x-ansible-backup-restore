#!/usr/bin/python

import sys
import getopt
import cassandra
from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider

def main(argv):
    contact_points = ''
    username = ''
    password = ''
    connect_timeout = 60
    try:
        opts, args = getopt.getopt(argv,"hc:u:p:",["contact_points=","username=","password="])
    except getopt.GetoptError:
        print 'get_keyspaces.py -c <contact_points> -u <username> -p <password>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'get_keyspaces.py -c <contact_points> -u <username> -p <password>'
            sys.exit()
        elif opt in ("-c", "--contact_points"):
            contact_points = arg.split(",")
        elif opt in ("-u", "--username"):
            username = arg
        elif opt in ("-p", "--password"):
            password = arg

    auth_provider = PlainTextAuthProvider(username=username, password=password)
    cluster = Cluster(contact_points=contact_points, control_connection_timeout=connect_timeout, auth_provider=auth_provider)
    session = cluster.connect('system')
    rows = session.execute('SELECT keyspace_name FROM schema_keyspaces')
    for row in rows:
        print row.keyspace_name

if __name__ == "__main__":
    main(sys.argv[1:])
