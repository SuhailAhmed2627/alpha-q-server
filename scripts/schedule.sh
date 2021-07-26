#! bin/bash

DATE=$(date +%Y-%m-%d)
DOMAINS=(sysAd appDev webDev)
while read date_col time_col; do
   if [ ${date_col} = ${DATE} ]; then
      for domain in ${DOMAINS[*]}; do
         for i in {1..9}; do
            touch /home/${domain}_0${i}/schedule.txt
            echo "${date_col} ${time_col}" >>/home/${domain}_0${i}/schedule.txt
         done
         touch /home/${domain}_10/schedule.txt
         echo "${date_col} ${time_col}" >>/home/${domain}_10/schedule.txt
         for i in {11..30}; do
            touch /home/${domain}_${i}/schedule.txt
            echo "${date_col} ${time_col}" >>/home/${domain}_${i}/schedule.txt
         done
      done
   fi
done </home/Jay_Jay/future.txt
