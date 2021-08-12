#!/bin/bash
set -e

echo "  ----- Cloning application repo -----  "
git clone https://github.com/Artemmkin/raddit.git

echo "  ----- Installing dependent gems -----  "
cd ./raddit
sudo bundle install

echo "  ----- Starting the application -----  "
sudo systemctl start raddit
sudo systemctl enable raddit
