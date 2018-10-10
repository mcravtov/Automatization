#!/bin/bash

user=$1
if [ -z "$user" ]; then
    echo "Error: no user specified"
    echo "Usage: $0 USERNAME"
fi

if [ ! -e "/home/$user" ]; then
    echo "Error: /home/$user doesn't exist"
    exit 1
fi

# Copy keys
cp -r /root/keys/.ssh /home/$user/
chown -R $user:$user /home/$user/.ssh

# Copy drush
#cp -r /root/.drush /home/$user/
#chown -R $user:$user /home/$user/.drush

# Set bash as system shell
v-change-user-shell $user bash

exit
