#!/bin/bash
# run this as superuser, this script is used to incorporate aliases and make the system run schedule at 00:00, everyday
cd ~
echo "alias genUser='bash /home/genUser.sh'" >>.bashrc
echo "alias permit='bash /home/permit.sh'" >>.bashrc
echo "alias schedule='bash /home/schedule.sh'" >>.bashrc
echo "alias attendance='bash /home/attendance.sh'" >>.bashrc

sudo echo "0 0 * * * root ./schedule" >>/etc/crontab
