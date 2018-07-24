#!/bin/bash

# Display the UID
echo "Your UID is ${UID}"

## Only display if the UID does NOT match 1000
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Your UID does not match ${UID_TO_TEST_FOR}"
  exit 1
fi

USER_NAME=$(id -un)

# Test if the command succeeded
if [[ "${?}" -ne 0 ]] ## $? exit status
then
  echo 'The id command did not execute successfully.'
fi
echo "Your username is ${USER_NAME}"

# You can use a string test conditional
USER_NAME_TO_TEST_FOR='vagrant'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]] # double equal sign -> pattern match
then
  echo "Your name matches ${USER_NAME_TO_TEST_FOR}."
fi

# Test for != (not equal) for the string
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
  echo "Your name does not match ${USER_NAME_TO_TEST_FOR}."
  exit 1
fi
