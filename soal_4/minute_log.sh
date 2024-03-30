#!/bin/bash

# Menentukan waktu saat ini
timestamp=$(date +"%Y%m%d%H%M%S")

# Mendapatkan informasi RAM
mem_total=$(free -m | awk '{print $2}')
mem_used=$(free -m | awk '{print $3}')
mem_free=$(free -m | awk '{print $4}')
mem_shared=$(free -m | awk '{print $5}')
mem_buff=$(free -m | awk '{print $6}')
mem_available=$(free -m | awk '{print $7}')

# Mendapatkan informasi swap
swap_total=$(free -m | awk '{print $8}')
swap_used=$(free -m | awk '{print $9}')
swap_free=$(free -m | awk '{print $10}')

# Mendapatkan informasi path dan size directory
path="/home/$vboxuser/Documents"
path_size=$(du -sh $path | awk '{print $1}')

# Menulis informasi ke file log
echo "$mem_total,$mem_used,$mem_free,$mem_shared,$mem_buff,$mem_available,$swap_total,$swap_used,$swap_free,$path,$path_size" >>/home/$vboxuser/log/metrics_$timestamp.log
