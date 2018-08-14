#!/bin/bash

## Generate new key
read -p "Your email:" EMAIL_ADDR
ssh-keygen -t rsa -b 4096 -C "${EMAIL_ADDR}"


## Adding your SSH key to the ssh-agent
eval "$(ssh-agent -s)"
echo "Host*" >> ~/.ssh/config
echo " AddKeysToAgent yes" >> ~/.ssh/config
echo " eKeychain yes">> ~/.ssh/config
echo " IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

## Add your SSH private key to the ssh-agent and store your passphrase in the keychain.
ssh-add -K ~/.ssh/id_rsa

## Setup public-key
pbcopy < ~/.ssh/id_rsa.pub
echo "Add new SSH key to github and Paste public-key"

## Test SSH connection
ssh -T git@github.com

read -p "GitHub repo url:" GITHUB_URL
echo "Clone your github repo"
git clone "${GITHUB_URL}"

## Update url for SSH
read -p "Update URL for SSH:" SSH_URL
git remote set-url origin "${SSH_URL}"




