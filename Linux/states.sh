#!/bin/bash

# states list

states=('New York' 'Arizona' 'Texas')

# script to check which state is cool. 

for state in "${states[@]}"
do
    if [[ "$state" == 'New York' ]]
    then
	echo 'New York is cool'
    else
	echo 'Arizona rocks'
    fi
done
