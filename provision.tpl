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
      EXTERNAL_IP=$(dig +short matrix.pguerra.link | awk '{ print ; exit }')
    append: true

scripts-user:
  - sudo source /etc/environment
  - sudo git clone https://github.com/PedroGuerraPT/matrix-docker-ansible-deploy.git
  - sudo cd matrix-docker-ansible-deploy
  - sudo ansible-playbook -i inventory/hosts setup.yml --tags=setup-all
