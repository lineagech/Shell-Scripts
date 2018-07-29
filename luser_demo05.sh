#!/bin/bash

# Generate a list of random passwords

PASSWORD=${RANDOM}
echo "${PASSWORD}"

# Three random numbers together
PASSWORD=${RANDOM}${RANDOM}${RANDOM}
echo "${PASSWORD}"

PASSWORD=$(date +%s)
echo "${PASSWORD}"

# Use nanoseconds to act as randomization
PASSWORD=$(date +%s%M)
echo "${PASSWORD}"

# A better password
PASSWORD=$(date +%s | sha256sum | head -c32)
echo "${PASSWORD}"

# A even better password
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

# Append a special character to the password
SPECIALCHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1 )
echo "${PASSWORD}${SPECIALCHARACTER}"
