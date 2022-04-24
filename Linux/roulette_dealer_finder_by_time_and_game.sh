#!/bin/bash

cat  *_Dealer_schedule | sed -n '1p'

cat  $1_Dealer_schedule | grep "$2" 


