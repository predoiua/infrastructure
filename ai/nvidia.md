
# Nvidia rtx-3090

## nvidia-smi = NVIDIA System Management Interface

~~~bash
nvidia-smi -q -d POWER

# Enabled persistence mode via daemon for GPU 00000000:01:00.0.
sudo nvidia-smi -pm 1
# set max power allow to use
sudo nvidia-smi -pl 260
Power limit for GPU 00000000:01:00.0 was set to 260.00 W from 370.00 W.
~~~

persistent power limit

~~~
sudo vim /etc/systemd/system/rtx-power-limit.service
[Unit]
Description=Set RTX 3090 Power Limit to 260W
After=syslog.target network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/nvidia-smi -pl 260

[Install]
WantedBy=multi-user.target
~~~

~~bash
sudo systemctl daemon-reload
sudo systemctl enable rtx-power-limit.service

sudo systemctl start rtx-power-limit.service # test it
nvidia-smi --query-gpu=power.limit --format=csv # check

~~~

## nvtop
