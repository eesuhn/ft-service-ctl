## ft-service-ctl

Script to manage the status of services with `systemctl`

#### Installation
1. Clone in root:
	```sh
	git clone https://github.com/eesuhn/ft-service-ctl.git ~/.ft-service-ctl
	```
2. Run set-up script:
	```sh
	source ~/.ft-service-ctl/set-up.sh
	```

#### Usage
```sh
fs <service> [option]
```
> `-i` to initialize service<br>
> `-s` to stop service<br>
> `-r` to reload service<br>
> <b>If no option is provided</b>, it checks the status and prompts to start if inactive
