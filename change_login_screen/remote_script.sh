#!/bin/bash

#created Name:Derick Kundukulam Sept 26th 2020 derickrk@asu.edu
# code to change the login screen of a MacOS system remotely
# important: make sure the main disk is 'disk1s5'


DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/error_handling.sh"

echo -e "logged in to remote machine\n"

echo -e "mounting disk..\n"
sudo mount -t apfs -wu /dev/disk1s5 /Volumes || error_exit "$LINENO: mounting failed "
mount -wu /; killall Finder                     # not necessary
echo -e "mounted\n"
echo -e "changing directory  to pictures directory\n"
cd /System/Library/Desktop\ Pictures || error_exit "$LINENO: could not access directory"            # go into this dir
echo -e "renaming old picture to Catalina.heic.old ....\n"
mv Catalina.heic    Catalina.heic.test || error_exit "$LINENO: could not rename file"          # rename old picture
echo -e "renamed\n"

echo -e "adding the login picture we want ...\n"
mv Catalina_original.heic Catalina.heic || error_exit "$LINENO: could not replace the required picture"

echo -e "added\n"
exit 0
