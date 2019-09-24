# Note
Need A Overseas VPS 
# Steps
1. `curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"`
2. `python get-pip.py`
3. `pip install shadowsocks`
4. `vim /etc/shadowsocks.json`

Edit`shadowsocks.json` As Follows
```
{
"server": "0.0.0.0",
"server_port": "36789",
"password": "yourpassword",
"timeout": "600",
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
`systemctl enable shadowsocks && systemctl start shadowsocks && systemctl stop firewalld && systemctl disable firewalld`

# install BBR
`wget https://raw.githubusercontent.com/NS-Sp4ce/ShadowSocksPanelFiles/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh`

# Update To 3.0 To Support More Encrypt Method
1. `pip install https://github.com/shadowsocks/shadowsocks/archive/master.zip -U`
2. 
```
wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz
tar zxf LATEST.tar.gz
cd libsodium*
./configure
sudo make && sudo make install
```
3. Restart Shadowsocks And Enjoy

# V2ray
1. `wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh`
2. `pip install Flask-BasicAuth`
3. `v2ray`
4. `1`

# Uninstall AliYunDun
## Windows
```
http://update.aegis.aliyun.com/download/uninstall.bat?spm=a2c4g.11186623.2.5.h6JSZc&file=uninstall.bat 

```
## linux
```
wget http://update.aegis.aliyun.com/download/uninstall.sh
chmod +x uninstall.sh
./uninstall.sh
wget http://update.aegis.aliyun.com/download/quartz_uninstall.sh
chmod +x quartz_uninstall.sh
./quartz_uninstall.sh
pkill aliyun-service
rm  -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
rm  -rf /usr/local/aegis*
rm -rf /usr/sbin/aliyun*chkconfig --del cloudmonitor
```
