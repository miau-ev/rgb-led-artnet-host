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
mkdir -p /tmp/nodejs
cd /tmp/nodejs
wget https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-armv6l.tar.xz
tar -xvf node-v8.11.1-linux-armv6l.tar.xz
cd node-v8.11.1-linux-armv6l
sudo cp -r bin /usr/local/
sudo cp -r include /usr/local/
sudo cp -r lib /usr/local/
sudo cp -r share /usr/local/
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
