#! bin/bash
DOMAINS=(sysAd appDev webDev)

arg_1=${1:-2000-01-01} # Set arg_1 as 2000-01-01 if no arguments where passed
arg_2=${2:-3000-01-01} # Set arg_2 as 3000-01-01 if no arguments where passed

date_u=$(date -d $arg_1 +"%Y-%m-%d") # date_u is the starting date
date_v=$(date -d $arg_2 +"%Y-%m-%d") # date_v is the ending date

# using awk we get the user and the meetings's date into properAtt.txt, a temporary file
awk -F'[, ]' -v date_v="$date_v" -v date_u="$date_u" '{
      if ($3 <= date_v && $3 >= date_u)
         print $1, $3
   }' /home/attendance-log.txt >properAtt.txt

DATES=$(awk '!($2 in a){a[$2];print $2}' properAtt.txt) # An array containing the dates that we actually need to look for

# use grep with every username and dates of meet to find who all were not present
for date in ${DATES[*]}; do
   for domain in ${DOMAINS[*]}; do
      for i in {1..9}; do
         if [ $(grep -c "${domain}_0${i} ${date}" properAtt.txt) == 0 ]; then
            echo ${domain}_0${i} was absent on ${date}
         fi
      done
      if [ $(grep -c "${domain}_10 ${date}" properAtt.txt) == 0 ]; then
         echo ${domain}_10 was absent on ${date}
      fi

      for i in {11..30}; do
         if [ $(grep -c "${domain}_${i} ${date}" properAtt.txt) == 0 ]; then
            echo ${domain}_${i} was absent on ${date}
         fi
      done
   done
done

# delete the temporary properAtt.txt
sudo rm -rf properAtt.txt
