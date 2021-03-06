#!/bin/bash


## Disable
# change -E 0 ${USER}
# passwd -l ${USER}
# passwd -u ${USER}
# usermod -s /sbin/nologin ${USER}


# This script deletes a user

# Run as root

if [[ "${UID}" -ne 0 ]]
then
    echo 'Please run with sudo or as root' >&2
    exit 1
fi

# Assume the first argu is the user to delete
USER=${1}

# Delete the user
usedel ${USER}

# Make sure the user got deleted
if [[ "${?}" -ne 0 ]]
then
  echo "The account ${USER} was NOT deleted" >&2
  exit 1
fi

# Tell the user the account was deleted.
echo "The account ${USER} was deleted."

exit 0
