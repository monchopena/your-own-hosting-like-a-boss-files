#!/bin/bash

while [ true ]
do
    echo 'doing curl to wordpress in a loop ...'
    curl -s  http://wordpress.local > /dev/null
    sleep 1
done