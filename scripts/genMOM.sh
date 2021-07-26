#! bin/bash

date_u=$(date -d 2000-01-01 +"%Y-%m-%d")
date_v=$(date -d 3000-01-01 +"%Y-%m-%d")

awk -F'[, ]' -v date_v="$date_v" -v date_u="$date_u" '{
      if ($3 <= date_v && $3 >= date_u)
         print $3
   }' /home/Jay_Jay/attendance-log.txt >properAtt.txt

ALL_DATES=$(awk '!($1 in a){a[$1];print $1}' properAtt.txt)

sudo rm properAtt.txt

DATES=($(echo "${ALL_DATES[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

for date in ${DATES[*]}; do
   >temp.txt

   for i in {1..9}; do
      grep -i "_0${i} - ${date}" /home/Jay_Jay/attendance-log.txt >>temp.txt
   done
   grep -i "10 - ${date}" /home/Jay_Jay/attendance-log.txt >>temp.txt

   sed 's/://g' temp.txt >temp1.txt

   sort -k4 temp1.txt >temp.txt

   sudo rm temp1.txt

   tail -1 temp.txt >temp1.txt

   awk -F'[, ]' '{
      print $1, $3
   }' temp1.txt >>temp2.txt

   sudo rm temp1.txt
done

while read mem meet; do
   sudo touch /home/${mem}/${meet}_mom.txt
   sudo chmod o=rw- /home/${mem}/${meet}_mom.txt
   sudo echo "Ugh i have to take MoM, Everybody wants a happy ending. Right? But it doesnt always roll that way. Maybe this time. Im hoping if you play this back, its in celebration. I hope families are reunited, I hope we get it back and something like a normal version of the planet has been restored, if there ever was such a thing. God, what a world. Universe, now. If you told me ten years ago that we werent alone, let alone, you know, to this extent, I mean, I wouldnt have been surprised, but come on. The epic forces of dark and light that have come in to play. And for better or worse, thats the reality Morgans gonna have to find a way to grow up in. So I thought I better record a little greeting, in the case of an untimely death, on my part. I mean, not that death at any time isnt untimely. This time travel thing we are gonna try and pull off tomorrow, its got me scratching my head about the survivability of it all. Then again thats the hero gig. Part of the journey is the end. What am I even tripping for? Everythings gonna workout exactly the way its supposed to." >/home/${mem}/${meet}_mom.txt
done <temp2.txt

sudo rm temp2.txt
