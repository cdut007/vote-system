#!/bin/bash

file=$1
environment=$2

if test -z ${environment}
then
    environment=staging
fi

if test -z ${file}
then
	echo "must special a file name"
else

	#spring app start bash
	nohup java -jar ${file} --spring.profiles.active=${environment} > smile.out 2>&1 &

fi
