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
  - source: "ppa:ansible/ansible-2.8"

package_update: true
packages:
  - ansible
  - dnsutils
  - gawk
  - git

runcmd:
  - [ sh, -c, "git clone https://github.com/PedroGuerraPT/matrix-docker-ansible-deploy.git" ]
  - [ cd, matrix-docker-ansible-deploy ]
  - [ sh, -c, "ansible-playbook -i inventory/hosts setup.yml --tags=setup-all" ]
  - [ sh, -c, "ansible-playbook -i inventory/hosts setup.yml --tags=start" ]
  - [ sh, -c, "ansible-playbook -i inventory/hosts setup.yml --extra-vars='username=${ dimension_user } password=${ dimension_password } admin=yes' --tags=register-user" ]
