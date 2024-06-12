#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
PURPLE=$(tput setaf 5)
NC=$(tput sgr0)

if [ $# -eq 0 ]; then
	echo "Usage: fs <service>"
	exit 1
fi

SERVICE="$1"

if [[ "$(systemctl status $SERVICE 2>&1)" == *"Unit $SERVICE.service could not be found."* ]]; then
	echo "${RED}Error${NC}: ${SERVICE} does not exist"
	exit 1
fi

STATUS=$(systemctl is-active $SERVICE)

check_status() {
	if [ $STATUS = "active" ]; then
		echo "${SERVICE} is ${GREEN}active${NC}"
		read -p "Do you want to stop ${SERVICE}? [y/n] " RESPONSE
	else
		echo "${SERVICE} is ${RED}inactive${NC}"
		read -p "Do you want to start ${SERVICE}? [y/n] " RESPONSE
	fi
}

init_service() {
	if [ $STATUS = "active" ]; then
		echo "${SERVICE} is already ${GREEN}initialized${NC}"
		exit 1
	fi

	sudo systemctl start $SERVICE
	if [ $? -eq 0 ]; then
		echo "${SERVICE} has been ${GREEN}initialized${NC}"
	else
		echo "${SERVICE} failed to start"
		exit 1
	fi
}

stop_service() {
	if [ $STATUS = "inactive" ]; then
		echo "${SERVICE} is already ${RED}stopped${NC}"
		exit 1
	fi

	sudo systemctl stop $SERVICE
	if [ $? -eq 0 ]; then
		echo "${SERVICE} has been ${RED}stopped${NC}"
	else
		echo "${SERVICE} failed to stop"
		exit 1
	fi
}

reload_service() {
	if [ $STATUS = "inactive" ]; then
		echo "${SERVICE} can't be reloaded because it is ${RED}stopped${NC}"
		exit 1
	fi

	sudo systemctl reload $SERVICE
	if [ $? -eq 0 ]; then
		echo "${SERVICE} has been ${PURPLE}reloaded${NC}"
	else
		echo "${SERVICE} failed to reload"
		exit 1
	fi
}

if [ "$2" == "-i" ]; then
	init_service
elif [ "$2" == "-s" ]; then
	stop_service
elif [ "$2" == "-r" ]; then
	reload_service
else
	check_status
	if [[ $RESPONSE =$HOME ^[Yy]$ ]]; then
		if [ $STATUS = "active" ]; then
			stop_service
		else
			init_service
		fi
	fi
fi
