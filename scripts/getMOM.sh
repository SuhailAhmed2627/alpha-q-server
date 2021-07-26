#! bin/bash

arg_1=${1:-2000-01-01} # Set arg_1 as 2000-01-01 if no arguments where passed
arg_2=${2:-3000-01-01} # Set arg_2 as 3000-01-01 if no arguments where passed

date_u=$(date -d $arg_1 +"%Y-%m-%d")
date_v=$(date -d $arg_2 +"%Y-%m-%d")

awk -F'[, ]' -v date_v="$date_v" -v date_u="$date_u" '{
      if ($3 <= date_v && $3 >= date_u)
         print $3
   }' /home/attendance-log.txt >properAtt.txt

ALL_DATES=$(awk '!($1 in a){a[$1];print $1}' properAtt.txt)

sudo rm properAtt.txt

DATES=($(echo "${ALL_DATES[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

for date in ${DATES[*]}; do
   for i in {1..9}; do
      grep -i "_0${i} - ${date}" /home/attendance-log.txt >>temp.txt
   done
   grep -i "10 - ${date}" /home/attendance-log.txt >>temp.txt

   sed 's/://g' temp.txt >temp1.txt

   sort -k4 temp1.txt >temp.txt

   sudo rm temp1.txt

   tail -1 temp.txt >temp1.txt

   awk -F'[, ]' '{
      print $1, $3
   }' temp1.txt >>temp2.txt
   sudo rm temp.txt
   sudo rm temp1.txt
done

while read member date; do

   echo $member $date $(date -d $date +'%W %Y') >>temp.txt

done <temp2.txt

sudo rm temp2.txt
touch ~/MoM_records.txt
>~/MoM_records.txt
while read member date week year; do
   if [ $(grep -c "MoM of ${date}, by ${member}" ~/MoM_records.txt) == 0 ]; then
      echo MoMs of Week No:$week of year $year : >>~/MoM_records.txt
      echo "" >>~/MoM_records.txt

      grep -w "${week} ${year}" temp.txt >temp1.txt

      while read member date week year; do
         echo MoM of ${date}, by ${member}: >>~/MoM_records.txt
         sudo cat /home/${member}/${date}_mom.txt >>~/MoM_records.txt
         echo "" >>~/MoM_records.txt
      done <temp1.txt
      echo "" >>~/MoM_records.txt
   fi
done <temp.txt

cat ~/MoM_records.txt

rm temp.txt
rm temp1.txt
