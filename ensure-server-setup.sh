#!/bin/bash

ssh -l ubuntu "${1}" sudo apt-get remove docker docker-engine docker.io containerd runc
ssh -l ubuntu "${1}" curl -fsSL https://download.docker.com/linux/ubuntu/gpg \| sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
ssh -l ubuntu "${1}" echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) stable" \| sudo tee /etc/apt/sources.list.d/docker.list \> /dev/null
ssh -l ubuntu "${1}" sudo apt-get update
ssh -l ubuntu "${1}" sudo apt-get install -y docker-ce docker-ce-cli containerd.io
ssh -l ubuntu "${1}" sudo usermod -G docker ubuntu
