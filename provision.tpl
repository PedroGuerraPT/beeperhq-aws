#cloud-config
users:
  - default
  - name: pedro.guerra
    gecos: Pedro Guerra
    primary_group: users
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    ssh_import_id:
    lock_passwd: false
    ssh_authorized_keys:
      - ${ ssh_public_key }

apt_sources:
  - source: http://ppa.launchpad.net/ansible/ansible-2.8/ubuntu bionic main 

package_update: true
packages:
  - ansible
  - dnsutils
  - gawk
  - git

write_files:
  - path: /etc/environment
    permissions: 0644
    content: |
      BEEPER_DNS=${ beeper_dns }
      EXTERNAL_IP=$(dig +short ${ beeper_dns } | awk '{ print ; exit }')
    append: true

runcmd:
  - [ sh, -c, "git clone https://github.com/PedroGuerraPT/matrix-docker-ansible-deploy.git" ]
  - [ cd, matrix-docker-ansible-deploy ]
  - [ sh, -c, "ansible-playbook -i inventory/hosts setup.yml --tags=setup-all" ]
