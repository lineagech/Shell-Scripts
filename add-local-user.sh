#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ ${UID} -ne 0 ]]
then
  echo "Please run with sudo or as root"
  exit 1
fi
# Get the username (login).
read -p "Enter the username to create: " USER_NAME

# Get the real name (contents for the description field).
read -p "Enter the name of the person or application that will be using this account: " NAME

# Get the password.
read -p "Enter the password to use for the account:" PASSWORD

# Create the user with the password.
useradd --comment "${NAME}" --create-home "${USER_NAME}"

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne "0" ]]
then
  echo "useradd failed!"
  exit 1
fi

# Set the password.
echo "${PASSWORD}" | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne "0" ]]
then
  echo "passwd failed!"
  exit 1
fi

# Force password change on first login.
passwd -f -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
HOST=$(hostname)
echo
echo "username:"
echo "${USER_NAME}"
echo
echo "password:"
echo ${PASSWORD}
echo
echo "host:"
echo ${HOST}
exit 0
