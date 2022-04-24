#!/bin/bash

#State Variable

states=('Tennessee' 'Arizona' 'California' 'Hawaii' 'Virginia')

#check for state

for state in ${states[@]}
do
    if [ $state = Hawaii ] || [ $state = Arizona ]
    then
	echo $state '- This state is the best.'
    else
	echo $state '- This state is not the best.'
    fi
done 
