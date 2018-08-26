#!/bin/bash

# Display the usage and exit.
function usage {
  echo "Do not execute this script as root. Use the -s option instead."
  echo "Usage: ./run-everywhere.sh [-nsv] [-f FILE] COMMAND"
  echo "Executes COMMAND as a single command on every server."
  echo "  -f FILE Use FILE for the list of servers. Default: /vargarnt/servers."
  echo "  -n Dry run mode. Display the COMMAND that would have been executed and exit."
  echo "  -s Execute the COMMAND using sudo on the remote server."
  echo "  -v Verbose mode. Displays the server name before executing COMMAND."
  exit 1
}

function log {
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${1}"
  fi
}
# Make sure the script is not being executed with superuser privileges.
if [[ ${UID} -eq 0 ]]
then
  usage
fi

# Parse the options.
FILE="/vagrant/servers"
while getopts f:nsv OPTION
do
  case ${OPTION} in
    f)
      FILE=${OPTARG}
      ;;
    n)
      DRY_RUN='true'
      ;;
    s)
      SUDO='sudo'
      ;;
    v)
      VERBOSE='true'
      ;;
    ?)
      usage
      ;;
  esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"
# If the user doesn't supply at least one argument, give them help.
if [[ -z ${1} ]]
then
  usage
else
  COMMAND=${1}
fi
# Anything that remains on the command line is to be treated as a single command.

# Make sure the SERVER_LIST file exists.
if [[ ! -e ${FILE} ]]
then
  echo "Cannot open server list file /path/to/nowhere."
  exit 1
fi

# Loop through the SERVER_LIST
for SERVER in $(cat ${FILE})
do
  if [[ ${DRY_RUN} = 'true' ]]
  then
    # If it's a dry run, don't execute anything, just echo it.
    echo "ssh -o ConnectTimeout=2 "${SERVER}" "${COMMAND}""
  else
    ssh -o ConnectTimeout=2 "${SERVER}" "${SUDO}" "${COMMAND}"
    # Capture any non-zero exit status from the SSH_COMMAND and report to the user.
    if [[ ${?} -ne 0 ]]
    then
      exit 1
    fi
  fi
done

exit 0
