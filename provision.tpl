#cloud-config
fqdn: ${ beeper_tld }

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
  - source: "ppa:ansible/ansible-2.9"

package_update: true
packages:
  - ansible
  - dnsutils
  - gawk
  - git
  - python-pip

runcmd:
  - [ pip, install, dnspython, boto, boto3, botocore, docker ]
  - [ sh, -c, "git clone https://github.com/PedroGuerraPT/matrix-docker-ansible-deploy.git" ]
  - [ cd, matrix-docker-ansible-deploy ]
  - [ sh, -c, "ansible-galaxy collection install community.aws"]
  - [ sh, -c, "ansible-playbook -i inventory/hosts setup.yml --tags=setup-all" ]
  - [ sh, -c, "ansible-playbook -i inventory/hosts setup.yml --tags=start" ]
  - [ sh, -c, "ansible-playbook -i inventory/hosts setup.yml --extra-vars='username=${ element_user } password=${ element_password } admin=yes' --tags=register-user" ]
