#!/bin/sh

# This automates the installation of Docker stable.

python -mplatform | grep -qi ubuntu
is_ubuntu=$?

if [ $is_ubuntu -eq 0 ]; then
    echo "Installing Docker"
    # Install prereqs:
    apt-get install -y git curl debconf-utils
    # Get apt key and add repo
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    # Refresh repo
    apt-get -y update
    apt-get -y upgrade
    # Install bridge util and Docker-CE
    apt-get install -y bridge-utils
    apt-cache policy docker-ce
    apt-get install -y docker-ce
    # Hello Docker
    #service docker status
    # Add current user to Docker group to avoid pass on sudo
    usermod -aG docker ${USER}
    su - ${USER}
    id -nG
    # Add additional user to Docker group
    usermod -aG docker ocadmin
    #reboot now
else
        echo "Sorry this script is for Ubuntu only." 
fi
