#!/bin/sh

# bug fix for case sensitive filesystems
# without this myhs.homeseer.com wont load icons
ln -s /HomeSeer/html/images/homeseer /HomeSeer/html/images/HomeSeer
cp -n /HomeSeer/Data/PLUGINS/HSPI_*.exe /HomeSeer
sleep 3

mono /HomeSeer/HSConsole.exe --log
