shadowsocksDownloadAddress="https://raw.githubusercontent.com/NS-Sp4ce/ShadowSocksPanelFiles/master/shadowsocks.zip"
bbrDownloadAddress="https://raw.githubusercontent.com/NS-Sp4ce/ShadowSocksPanelFiles/master/bbr.sh"
echo "system Updating......."
yum update -y && yum upgrade -y
echo "Development Installing......."
yum -y groupinstall "Development Tools"
wget https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz
tar xf libsodium-1.0.16.tar.gz && cd libsodium-1.0.16
./configure && make -j2 && make install
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf 
ldconfig
cd /root
yum -y install python-setuptools wget unzip
easy_install pip
wget ${shadowsocksDownloadAddress}
if [ ! -x "/root/shadowsocks.zip"]
then
    wget ${shadowsocksDownloadAddress}
else
    unzip -q shadowsocks.zip
    cd shadowsocks
    pip install -r requirements.txt
    cp apiconfig.py userapiconfig.py
    cp config.json user-config.json
    wget "https://raw.githubusercontent.com/NS-Sp4ce/ShadowSocksPanelFiles/master/user-detect.html"
    chmod +x run.sh stop.sh
    systemctl stop firewalld.service
    systemctl disable firewalld.service
fi
echo "Now Install BBR"
wget --no-check-certificate ${bbrDownloadAddress} && chmod +x bbr.sh && ./bbr.sh
