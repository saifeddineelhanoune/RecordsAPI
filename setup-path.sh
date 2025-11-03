#!/bin/bash
# Add Go to PATH permanently
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
cd /mnt/c/Users/lenovo/Documents/TodoApi
/usr/local/go/bin/go mod tidy
/usr/local/go/bin/go run main.go
