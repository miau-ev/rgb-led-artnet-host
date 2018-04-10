#!/usr/bin/env bash
set -e

echo [1/5] Installing Dependencies...
sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
        git \
        build-essential \
        pigpio
echo Done

echo [2/5] Installing Node.JS...
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
echo Done

echo [3/5] Installing gpio-artnet-node...
git clone https://github.com/maxjoehnk/gpio-artnet-node.git
cd gpio-artnet-node
npm i
echo Done

echo [4/5] Setting up Systemd Service...
cp gpio-artnet-node.service /lib/systemd/system/
echo Done

echo [5/5] Activating Service...
sudo systemctl enable gpio-artnet-node
sudo systemctl start gpio-artnet-node
echo Done
