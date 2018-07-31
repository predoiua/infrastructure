# Util

- Service location
/usr/lib/systemd/system/node.service

- Show param
systemctl show node.service -p TimeoutStartSec
systemctl show node.service -p TimeoutStopSec
systemctl show node.service -p TimeoutSec

- 
systemctl reload node.service

- 
systemctl --no-block start node