#!/bin/bash
cd ..
printf "Enter the Enterprise username: "
read  USERNAME
printf "Enter the Enterprise password: "
read -s PASSWORD
echo ""
export ENTERPRISE_USERNAME=$USERNAME

printf "Enter a name (prefix) for the VM: "
read name

echo "The cluster name prefix is: $name"

printf "Enter how many GPU workers you want to have: "
read gpu_workers

re='^[0-9]+$'
if ! [[ $gpu_workers =~ $re ]] ; then
    echo "error: Not a valid number: $gpu_workers" >&2;
    exit 1
fi

ENTERPRISE_PASSWORD=$PASSWORD ./hopsworks-cloud-installer.sh -n $name -i kubernetes -ni -c azure -d https://nexus.hops.works/repository -w 0 -g $gpu_workers --debug -gt k80 -gpus 1
