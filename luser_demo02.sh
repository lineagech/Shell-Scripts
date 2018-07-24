#!/bin/bash
##

echo "Your UID is ${UID}"

USER_NAME=$(id -un) ## `id -un`, older way
echo "Your username is ${USER_NAME}"

## Display if the user is the root user or not
# tyep -a if
if [[ "${UID}" -eq 0 ]] ## [ is built-in command in bash
then
  echo "You are root"
else
  echo "You are not root"
fi
