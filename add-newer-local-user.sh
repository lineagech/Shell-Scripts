#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ ${UID} -ne 0 ]]
then
  echo "Please run with sudo or as root." >&2
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..."
  echo "Create an account on the local system with the name of USER_NAME and a comments field of COMMENT"
  exit 1
fi

# The first parameter is the user name.
USER_NAME="${1}"
shift

# The rest of the parameters are for the account comments.
COMMENT="${@}"

# Generate a password.
PASSWORD=$(date +%s%N | sha256sum | head -c48)
SPECIALCHARACTER=$(echo "~!@#$%^&*()_+" | fold -w1 | shuf | head -c1)
PASSWORD=${PASSWORD}${SPECIALCHARACTER}

# Create the user with the password.
useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The account could not be created."
  exit 1
fi

# Set the password.
#echo "Changing password for user ${USER_NAME}."
echo "${PASSWORD}" | passwd --stdin ${USER_NAME} &> /dev/null

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "The password for the account could not be set." >&2
  exit 1
fi

#echo "passwd: all authentication tokens updated successfully."
# Force password change on first login.
#echo "Expiring password for user ${USER_NAME}."

passwd -f -e ${USER_NAME} &> /dev/null

#echo "passwd: Success"
# Display the username, password, and the host where the user was created.
echo
echo "username:"
echo "${USER_NAME}"
echo
echo "password:"
echo "${PASSWORD}"
echo
echo "host:"
echo "${HOSTNAME}"
exit 0



