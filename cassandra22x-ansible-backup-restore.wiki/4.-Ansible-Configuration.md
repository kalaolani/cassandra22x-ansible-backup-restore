Following best practices on directory and file organization: https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html
- ansible.cfg - using the default (sample in repo)
- hosts - using the default plus this smaple environment (sample in repo)

#### Ansible Configuration Testing
Using the ping module to test inventory (/etc/ansible/hosts file)
```
[root@ansible ~]# ansible cluster22 -m ping
cass2.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
cass1.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
cass3.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
[root@ansible ~]# ansible cluster22-deltakappa-dc -m ping
cass3.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
cass1.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
cass2.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
[root@ansible ~]# ansible cass2.deltakappa.com -m ping
cass2.deltakappa.com | SUCCESS => {
    "changed": false,
    "ping": "pong"
```