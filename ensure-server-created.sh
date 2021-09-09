#!/bin/bash

KEYNAME="awesome-key"
SG="awesome-sg"
TYPE="t3.micro"


I=$(aws ec2 describe-instances --filters='Name=instance-state-name,Values=running' | grep -c 'InstanceId')

if [ "$I" == "0" ]; then
    aws ec2 run-instances --image-id ami-0ff338189efb7ed37 --count 1 --instance-type ${TYPE} --key-name ${KEYNAME} --security-groups ${SG} &> /dev/null
    sleep 10
fi
HOSTNAME=$(aws ec2 describe-instances --filters='Name=instance-state-name,Values=running' | jq -r ".Reservations[].Instances[].NetworkInterfaces[].Association.PublicDnsName")
echo "${HOSTNAME}"

ssh -o "StrictHostKeyChecking no" -l ubuntu "${HOSTNAME}" exit
exit $?
