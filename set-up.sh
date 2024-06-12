#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
NC=$(tput sgr0)

if grep -q "alias fs" $HOME/.bashrc; then
	echo "${RED}Error${NC}: alias mn already exists"
	exit 1
fi

cat <<EOF >> $HOME/.bashrc

# FT-SERVICE
alias fs="$HOME/.ft-service-ctl/ft-service.sh"
EOF

source $HOME/.bashrc
echo "${GREEN}Success${NC}: alias fs has been added"
