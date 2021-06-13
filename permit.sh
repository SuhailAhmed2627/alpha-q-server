#!/bin/bash

DOMAINS=(sysAd appDev webDev)

for domain in ${DOMAINS[*]}; do
   for i in {1..9}; do
      # Setting up permissions for 2nd Years
      sudo chmod u=rwx,g=rwx,o=--- /home/${domain}_0${i}
      sudo setfacl -m g:${domain}_third_year:rwx /home/${domain}_0${i}
      sudo setfacl -m g:${domain}_fourth_year:rwx /home/${domain}_0${i}
      sudo setfacl -m g:Jay_Jay:rwx /home/${domain}_0${i}
   done
   # Setting up permissions for profile_10
   sudo chmod u=rwx,g=rwx,o=--- /home/${domain}_10
   sudo setfacl -m g:${domain}_third_year:rwx /home/${domain}_10
   sudo setfacl -m g:${domain}_fourth_year:rwx /home/${domain}_10
   sudo setfacl -m g:Jay_Jay:rwx /home/${domain}_10

   # Setting up permissions for 3rd Years
   for i in {11..20}; do
      sudo chmod u=rwx,g=rwx,o=--- /home/${domain}_${i}
      sudo setfacl -m g:${domain}_fourth_year:rwx /home/${domain}_${i}
      sudo setfacl -m g:Jay_Jay:rwx /home/${domain}_${i}
   done

   # Setting up permissions for 4th Years
   for i in {21..30}; do
      sudo chmod u=rwx,g=rwx,o=--- /home/${domain}_${i}
      sudo setfacl -m g:Jay_Jay:rwx /home/${domain}_${i}
   done
done
