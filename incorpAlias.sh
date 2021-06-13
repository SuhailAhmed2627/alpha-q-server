#! bin/bash
# this script is used to incoporate the aliases into .bashrc
cd ~
echo "alias genUser='bash /home/genUser.sh'" >>.bashrc
echo "alias permit='bash /home/permit.sh'" >>.bashrc
echo "alias schedule='bash /home/schedule.sh'" >>.bashrc
echo "alias attendance='bash /home/attendance.sh'" >>.bashrc
