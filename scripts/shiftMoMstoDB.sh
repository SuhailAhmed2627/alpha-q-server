#! bin/bash

date_u=$(date -d 2000-01-01 +"%Y-%m-%d")
date_v=$(date -d 3000-01-01 +"%Y-%m-%d")

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
   sudo mysql -uroot -prootpsswrd alphaQ -e "INSERT INTO MoMs(member, mom_date, content) VALUES('$member', '$date', '$(sudo cat /home/${member}/${date}_mom.txt)')"
done <temp2.txt

sudo rm temp2.txt
