#!/bin/bash

function force_remove() {
    yum -y remove openldap-clients openldap-servers
    rm -rf /etc/openldap/                        ## ??? not sure about certificates
   # rm -rf /etc/openldap/slap.d/
    rm -rf /var/lib/ldap
    userdel ldap
}


function install_ldap() {
    yum -y install openldap openldap-clients openldap-servers
    systemctl enable slapd
    systemctl start slapd
}
