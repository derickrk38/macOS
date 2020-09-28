#!/bin/bash


#created Name:Derick Kundukulam Sept 26th 2020 derickrk@asu.edu
# code to change the login screen of a MacOS system remotely
# important: make sure the main disk is 'disk1s5'
# anyone is free to use this provided credits are mentioned

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/error_handling.sh"


function strip_spaces() {
  shopt -s extglob

  ### Trim leading whitespaces ###
  1 ="${1##*( )}"

  ### trim trailing whitespaces  ##
  1="${1%%*( )}"

  # turn it off
  shopt -u extglob
}



echo -e " \nChange of login screen script by Derick K\n"
echo -e "Enter username of remote system eg derick\n"
read user_name
strip_spaces user_name

echo -e "\nEnter DNS or ip of remote system\n eg  xxx@asu.edu or xxx.xxx.xxx.xxx\n"
read ip_address
strip_spaces ip_address

echo -e "\nEnter password of remote system\n"
read -s password


echo -e "\ncopying Catalina picture from local to remote system...\n"
sshpass -p "$password" scp Catalina.heic "$user_name"@"$ip_address":Catalina_original.heic || error_exit "$LINENO:Could not copy Catalina picture from local to remote system "
#sshpass -p $password scp Catalina.heic "$user_name"@"$ip_address":/home/derick/Desktop/change_login/haha.heic

echo -e "copied\n"

echo -e "logging into remote system....\n"
sshpass -p "$password" ssh  "$user_name"@"$ip_address" "bash -s" < remote_script.sh || error_exit "$LINENO: Logging in failed "

echo -e "exiting remote system..."
exit

echo -e "changing login screen successful. \n"
exit 0
