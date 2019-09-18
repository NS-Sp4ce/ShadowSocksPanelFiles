# Note
Need A Overseas VPS 
# Steps
1. `curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"`
2. `python get-pip.py`
3. `vim /etc/shadowsocks.json`
Edit`shadowsocks.json` As Follows
```
{
"server": "0.0.0.0",
"server_port": "36789",
"password": "yourpassword",
"timeout": 600,
"method": "aes-256-cfb"
}
```
# Enable Auto Run
`vim /etc/systemd/system/shadowsocks.service`

```
[Unit]
Description=Shadowsocks
[Service]
TimeoutStartSec=0
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json
[Install]
WantedBy=multi-user.target
```
`systemctl enable shadowsocks & systemctl start shadowsocks & systemctl stop firewalld & systemctl disable firewalld`
