#!/bin/bash

#make backup directory if none

mkdir -p /var/backup/home

#backing up /home to created directory

tar cvf /var/backup/home.tar /home

mv /var/backup/home.tar /var/backup/home.02242022.tar

ls -lh /var/backup > /var/backup/file_report.txt

free -h > /var/backup/disk_report.txt


