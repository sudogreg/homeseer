#!/bin/sh

# bug fix for case sensitive filesystems
# without this myhs.homeseer.com wont load icons
ln -s /HomeSeer/html/images/homeseer /HomeSeer/html/images/HomeSeer
mv /HomeSeer/Data/PLUGINS/override/*.* /HomeSeer
mv /HomeSeer/Data/PLUGINS/zips/*.* /HomeSeer/Updates3/Zips
sleep 2
mono /HomeSeer/HSConsole.exe --log
