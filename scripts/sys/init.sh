#!/usr/bin/env bash

# create a user
DOCKER_USER=${DOCKER_USER:-haozou}
DOCKER_USER_ID=${DOCKER_USER_ID:-1001}
DOCKER_PASSWORD=${DOCKER_PASSWORD:-$DOCKER_USER}
DOCKER_GROUP=${DOCKER_GROUP:-docker}
DOCKER_GROUP_ID=${DOCKER_GROUP_ID:-1001}
/scripts/sys/create_user.sh -u $DOCKER_USER -i $DOCKER_USER_ID -p $DOCKER_PASSWORD -g $DOCKER_GROUP -r $DOCKER_GROUP_ID
gpasswd -a $DOCKER_USER sudo

echo "#env var" > /home/$DOCKER_USER/.env_var
chown -R $DOCKER_USER:$DOCKER_GROUP /home/$DOCKER_USER/.env_var

source /scripts/env/proxychains.sh
echo "[$(tput setaf 6)INFO$(tput sgr0)] $(tput setaf 4)Proxychains$(tput sgr0) settled"

# chown -R $DOCKER_USER:$DOCKER_GROUP /workdir
su $DOCKER_USER -c 'source /scripts/usr/zsh.sh'
# source /scripts/usr/zsh.sh
echo "[$(tput setaf 6)INFO$(tput sgr0)] $(tput setaf 4)zsh$(tput sgr0) settled"
