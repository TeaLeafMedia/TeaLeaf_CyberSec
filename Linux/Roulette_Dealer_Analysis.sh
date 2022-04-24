#!/bin/bash

cat *schedule | grep $1 | grep $2 | awk '{print $1, $2, $5, $6}'

