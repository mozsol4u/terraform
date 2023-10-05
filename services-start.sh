#!/bin/bash

# Start Nginx
sudo systemctl start nginx

# Wait for 2 minutes (120 seconds)
sleep 120

# Start Mysql mysqld
sudo systemctl start httpd
