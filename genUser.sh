#!/bin/bash
DOMAINS=(sysAd appDev webDev) # Array with profiles

for domain in ${DOMAINS[*]}; do

   # Creating Groups
   sudo groupadd ${domain}_second_year
   sudo groupadd ${domain}_third_year
   sudo groupadd ${domain}_fourth_year

   for i in {1..30}; do
      if [ $i -le 10 ]; then
         if [ $i -eq 10 ]; then
            sudo useradd -m ${domain}_${i}                      # Create User
            sudo echo "${domain}_${i}:asdfasdf" | sudo chpasswd # Set User's password as "asdfasdf"
         else
            sudo useradd -m -G ${domain}_second_year ${domain}_0${i}
            sudo echo "${domain}_0${i}:asdfasdf" | sudo chpasswd
         fi
      elif [ $i -le 20 ]; then
         sudo useradd -m -G ${domain}_third_year ${domain}_${i}
         sudo echo "${domain}_${i}:asdfasdf" | sudo chpasswd

      else
         sudo useradd -m -G ${domain}_fourth_year ${domain}_${i}
         sudo echo "${domain}_${i}:asdfasdf" | sudo chpasswd
      fi
   done
done

# Creating Admin Jay_Jay
sudo useradd -m -G sudo Jay_Jay
sudo echo "Jay_Jay:asdfasdf" | sudo chpasswd
