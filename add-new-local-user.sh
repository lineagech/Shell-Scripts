#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ ${UID} -ne 0 ]]
then
  echo "Please run with sudo or as root."
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
if [[ $# -eq 0 ]]
then
  echo "Usage: ./add-new-local-user.sh USER_NAME [COMMENT]...
Create an account on the local system with the name of USER_NAME and a
comments field of COMMENT."
  exit 1
fi

# The first parameter is the user name.
USER_NAME=${1}
shift

# The rest of the parameters are for the account comments.
COMMENT=${*}

# Generate a password.
PASSWORD=$(date +%s%N | sha256sum | head -c48)
SPECIALCHARACTER=$(echo "~!@#$%^&*()_+" | fold -w1 | shuf | head -c1)
PASSWORD=${PASSWORD}${SPECIALCHARACTER}

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME}
# Check to see if the useradd command succeeded.
if [[ ${?} -ne 0 ]]
then
  echo "useradd failed"
  exit 1
fi
# Set the password.
echo "Changing password for user ${USER_NAME}."
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}
# Check to see if the passwd command succeeded.
if [[ ${?} -ne 0 ]]
then
  echo "passwd: Failed"
  exit 1
fi
echo "passwd: all authentication tokens updated successfully."
# Force password change on first login.
echo "Expiring password for user ${USER_NAME}."
passwd -f -e ${USER_NAME}
echo "passwd: Success"
# Display the username, password, and the host where the user was created.
echo "username:"
echo "${USER_NAME}"
echo
echo "password:"
echo "${PASSWORD}"
echo
echo "host:"
HOST=$(hostname)
echo "${HOST}"
