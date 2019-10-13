# Monitor and alert program

Monitor the component process and alert with SMS when it go dead.

## Dependency

*	Linux
*	python 2.6 and later
*	SMS python API should be work perfect.

## Attention

The SMS text message must have the prefix 科大讯飞,or the CMCC phone numbers will not receive the messages.

## Install

./install.sh

# #Config
*	conf/config
*	phone numbers
*	services

## Start
./monitor start

## Stop
./monitor stop