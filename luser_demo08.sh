#!/bin/bash

# Redirect STDOUT to a file
FILE="/tmp/data"
head -n2 /etc/passwd > ${FILE}

# Redirect STDIN to a program
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file, overwriting the file
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDOUT to a file, appending to the file
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "Contents of ${FILE}:"
cat ${FILE}

# 0 stdin 1 stdout 2 stderr

# read X 0< /etc/centos-release
# &> 2>&1
# pipe -> only get from stdout
# |& pipe and redirect

read LINE 0< ${FILE}
echo
echo "LINE contains: ${LINE}"

head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}"
cat ${FILE}

## Redirect STDERR to a file using FD 2.
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

# Redirect STDOUT and STDERR to a file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect STDOUT and STDERR through a pipe
echo
head -n3 /etc/passwd /fakefile |& cat -n

# Send outpu to STDERR
echo "This is ERROR" >&2

# Discard STDOUT
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd /fakefile 2> /dev/null

# Discard STDOUT and STDERR
echo "Discarding STDOUT and STDERR:"
head -n3 /etc/passwd /fakefile &> /dev/null
echo
