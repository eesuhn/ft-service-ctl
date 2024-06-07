#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NC=$(tput sgr0)

if grep -q "alias fs" /home/$USER/.bashrc; then
	echo "${RED}Error${NC}: alias mn already exists"
	exit 1
fi

cat <<EOF >> /home/$USER/.bashrc

# FT-SERVICE
alias fs="/home/$USER/.ft-service-ctl/ft-service.sh"
EOF

source /home/$USER/.bashrc
echo "${GREEN}Success${NC}: alias fs has been added"
