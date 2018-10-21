# cassandra22x-ansible-backup-restore
See the Wiki for details.

Recently added ... cassandra22x_operate_rolling_full_partitioner-range_repair_by_node.yml
Need repairs to test restores.

## Restore is coming soon.
### sneak peak
```
[root@ansible ansible]# ansible-playbook playbooks/cluster22/cassandra22x_restore_local_keyspace.yml -e"snapshot_keyspace_yml=snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75_killrvideo.yml"

PLAY [cluster22] *************************************************************************************************************************************************************************************************************************************************************

TASK [capture playbook start time] *******************************************************************************************************************************************************************************************************************************************
ok: [cass1.deltakappa.com]
ok: [cass2.deltakappa.com]
ok: [cass3.deltakappa.com]

TASK [cassandra22x_restore_rsync_local_snapshots_by_keyspace : include the snapshot_keyspace yaml file per node] *************************************************************************************************************************************************************
ok: [cass1.deltakappa.com]
ok: [cass2.deltakappa.com]
ok: [cass3.deltakappa.com]

TASK [cassandra22x_restore_rsync_local_snapshots_by_keyspace : rsync hardlink local snapshot files back to the keyspace for all column families data directories on disk] ****************************************************************************************************
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=comments_by_user-44441930d01e11e8af9161a24d399e62)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=comments_by_user-44441930d01e11e8af9161a24d399e62)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=comments_by_user-44441930d01e11e8af9161a24d399e62)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=comments_by_video-431fe481d01e11e88aba9fbe3aadd836)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=latest_videos-401c1a63d01e11e8af9161a24d399e62)
ok: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=tags_by_letter-42768523d01e11e89422bbcdcbc5c11b)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=comments_by_video-431fe481d01e11e88aba9fbe3aadd836)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=comments_by_video-431fe481d01e11e88aba9fbe3aadd836)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=user_credentials-3d119983d01e11e88aba9fbe3aadd836)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=latest_videos-401c1a63d01e11e8af9161a24d399e62)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=latest_videos-401c1a63d01e11e8af9161a24d399e62)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=user_videos-3f8383e3d01e11e88aba9fbe3aadd836)
ok: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=tags_by_letter-42768523d01e11e89422bbcdcbc5c11b)
ok: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=tags_by_letter-42768523d01e11e89422bbcdcbc5c11b)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=user_credentials-3d119983d01e11e88aba9fbe3aadd836)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=user_credentials-3d119983d01e11e88aba9fbe3aadd836)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=users-3e553d13d01e11e8af9161a24d399e62)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=user_videos-3f8383e3d01e11e88aba9fbe3aadd836)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=user_videos-3f8383e3d01e11e88aba9fbe3aadd836)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=video_event-44e3dba3d01e11e89422bbcdcbc5c11b)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=video_rating-40af0b93d01e11e89422bbcdcbc5c11b)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=users-3e553d13d01e11e8af9161a24d399e62)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=users-3e553d13d01e11e8af9161a24d399e62)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=video_ratings_by_user-41550f91d01e11e88aba9fbe3aadd836)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=video_event-44e3dba3d01e11e89422bbcdcbc5c11b)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=video_event-44e3dba3d01e11e89422bbcdcbc5c11b)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=videos-3eedfaa3d01e11e89422bbcdcbc5c11b)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=video_rating-40af0b93d01e11e89422bbcdcbc5c11b)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=video_rating-40af0b93d01e11e89422bbcdcbc5c11b)
changed: [cass1.deltakappa.com -> cass1.deltakappa.com] => (item=videos_by_tag-41e58fc0d01e11e8af9161a24d399e62)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=video_ratings_by_user-41550f91d01e11e88aba9fbe3aadd836)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=video_ratings_by_user-41550f91d01e11e88aba9fbe3aadd836)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=videos-3eedfaa3d01e11e89422bbcdcbc5c11b)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=videos-3eedfaa3d01e11e89422bbcdcbc5c11b)
changed: [cass2.deltakappa.com -> cass2.deltakappa.com] => (item=videos_by_tag-41e58fc0d01e11e8af9161a24d399e62)
changed: [cass3.deltakappa.com -> cass3.deltakappa.com] => (item=videos_by_tag-41e58fc0d01e11e8af9161a24d399e62)

TASK [cassandra22x_restore_rsync_local_snapshots_by_keyspace : cassandra is the owner/group for all rsync-hardlink-ed files of the keyspace for all column families] *********************************************************************************************************
ok: [cass3.deltakappa.com]
ok: [cass1.deltakappa.com]
ok: [cass2.deltakappa.com]

TASK [cassandra22x_restore_refresh_colunmfamilies_by_keyspace : include the snapshot_keyspace yaml file per node] ************************************************************************************************************************************************************
ok: [cass1.deltakappa.com]
ok: [cass2.deltakappa.com]
ok: [cass3.deltakappa.com]

TASK [cassandra22x_restore_refresh_colunmfamilies_by_keyspace : nodetool-refresh.sh restored column family] ******************************************************************************************************************************************************************
changed: [cass1.deltakappa.com] => (item=comments_by_user)
changed: [cass3.deltakappa.com] => (item=comments_by_user)
changed: [cass2.deltakappa.com] => (item=comments_by_user)
changed: [cass3.deltakappa.com] => (item=comments_by_video)
changed: [cass1.deltakappa.com] => (item=comments_by_video)
changed: [cass2.deltakappa.com] => (item=comments_by_video)
changed: [cass3.deltakappa.com] => (item=latest_videos)
changed: [cass1.deltakappa.com] => (item=latest_videos)
changed: [cass2.deltakappa.com] => (item=latest_videos)
changed: [cass3.deltakappa.com] => (item=tags_by_letter)
changed: [cass1.deltakappa.com] => (item=tags_by_letter)
changed: [cass2.deltakappa.com] => (item=tags_by_letter)
changed: [cass3.deltakappa.com] => (item=user_credentials)
changed: [cass1.deltakappa.com] => (item=user_credentials)
changed: [cass2.deltakappa.com] => (item=user_credentials)
changed: [cass3.deltakappa.com] => (item=user_videos)
changed: [cass1.deltakappa.com] => (item=user_videos)
changed: [cass2.deltakappa.com] => (item=user_videos)
changed: [cass3.deltakappa.com] => (item=users)
changed: [cass1.deltakappa.com] => (item=users)
changed: [cass2.deltakappa.com] => (item=users)
changed: [cass1.deltakappa.com] => (item=video_event)
changed: [cass3.deltakappa.com] => (item=video_event)
changed: [cass2.deltakappa.com] => (item=video_event)
changed: [cass1.deltakappa.com] => (item=video_rating)
changed: [cass3.deltakappa.com] => (item=video_rating)
changed: [cass2.deltakappa.com] => (item=video_rating)
changed: [cass1.deltakappa.com] => (item=video_ratings_by_user)
changed: [cass3.deltakappa.com] => (item=video_ratings_by_user)
changed: [cass2.deltakappa.com] => (item=video_ratings_by_user)
changed: [cass1.deltakappa.com] => (item=videos)
changed: [cass3.deltakappa.com] => (item=videos)
changed: [cass2.deltakappa.com] => (item=videos)
changed: [cass1.deltakappa.com] => (item=videos_by_tag)
changed: [cass3.deltakappa.com] => (item=videos_by_tag)
changed: [cass2.deltakappa.com] => (item=videos_by_tag)

TASK [capture playbook end time] *********************************************************************************************************************************************************************************************************************************************
ok: [cass1.deltakappa.com]
ok: [cass2.deltakappa.com]
ok: [cass3.deltakappa.com]

TASK [cassandra22x_restore_local.yml play start and end date times] **********************************************************************************************************************************************************************************************************
ok: [cass1.deltakappa.com] => {
    "msg": "start_date_time: 20181021-120158 & end_date_time: 20181021-120240"
}
ok: [cass2.deltakappa.com] => {
    "msg": "start_date_time: 20181021-120158 & end_date_time: 20181021-120240"
}
ok: [cass3.deltakappa.com] => {
    "msg": "start_date_time: 20181021-120158 & end_date_time: 20181021-120240"
}

TASK [restore confirm message] ***********************************************************************************************************************************************************************************************************************************************
ok: [cass1.deltakappa.com] => {
    "msg": "Snapshot snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75 for the keyspaces killrvideo restored successfully... run a repair."
}
ok: [cass2.deltakappa.com] => {
    "msg": "Snapshot snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75 for the keyspaces killrvideo restored successfully... run a repair."
}
ok: [cass3.deltakappa.com] => {
    "msg": "Snapshot snapshot_2f6e2e95-cac1-4a1a-b653-07e19b410b75 for the keyspaces killrvideo restored successfully... run a repair."
}

PLAY RECAP *******************************************************************************************************************************************************************************************************************************************************************
cass1.deltakappa.com       : ok=9    changed=2    unreachable=0    failed=0
cass2.deltakappa.com       : ok=9    changed=2    unreachable=0    failed=0
cass3.deltakappa.com       : ok=9    changed=2    unreachable=0    failed=0
```

## Ad hoc Commands Notes...

wipe file servers of all cassandra archives
```
ansible cluster22 -m shell -a" rm -fR {{ cassandra22x_remote_archive_path }}/*"
```

## Ad hoc Environment Notes...

auto_snapshot is enabled by default & disabling auto_snapshot
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
 [WARNING]: Consider using the replace, lineinfile or template module rather than running sed.  If you need to use command because replace, lineinfile or template is insufficient you can add warn=False to this command task or set command_warnings=False in ansible.cfg
to get rid of this message.

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

ansible-playbook playbooks/cluster22/cassandra22x_operate_rolling_restart.yml
```
