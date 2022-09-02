#!/bin/bash
#written by Matt Moser

#find logged-in user
currentuser=$(/bin/ls -la /dev/console | /usr/bin/cut -d ' ' -f 4)
echo "The current user is: "$currentuser

#grant the logged-in user Admin rights
echo "Granting the" $currentuser "account admin rights..."
dseditgroup -o edit -a $currentuser -t user admin

#log all Admin users
Admins=$(members () { dscl . -list /Users | while read user; do printf "$user "; dsmemberutil checkmembership -U "$user" -G "$*"; done | grep "is a member" | cut -d " " -f 1; }; members admin)
echo "The current admin users are: "$Admins

exit
