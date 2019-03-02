> 全文转自https://9499460.com/15.html
**仅用做备份**

# 搭建环境
 - 核心：1CPU 
 - 内存：1G 
 - 架构：OVZ

# VPS系统：CentOS 7.x

# SSH 工具：Xshell 5.0

# 安装宝塔面板
`yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && bash install.sh`
安装完成后，登录面板，选择 LNMP 环境，PHP 版本选择 PHP 7.1 
等待 LNMP 安装完成。

# 添加网站
填写好自己的域名，没有域名就填写 IP，根目录改成 /www/wwwroot/sspanel 然后提交

进入网站目录，删除全部文件

# PHP 7.1 配置
打开PHP 7.1 设置：

配置修改：
![](https://i.imgur.com/llan4IP.png)

禁用函数：
![](https://i.imgur.com/VUPv5h2.png)

性能调整：
![](https://i.imgur.com/k2T81yl.png)

# 安装 SSPanel 程序
```
yum -y install unzip
cd /www/wwwroot/sspanel && wget https://github.com/NimaQu/ss-panel-v3-mod_Uim/releases/download/v2.2.0/SSPANEL.zip && unzip -q SSPANEL.zip
chown -R root:root *
chmod -R 755 *
chown -R www:www storage
php composer.phar install
mv tool/alipay-f2fpay vendor/
mv -f tool/cacert.pem vendor/guzzle/guzzle/src/Guzzle/Http/Resources/
mv -f tool/autoload_classmap.php vendor/composer/
```
# 数据库配置
点击侧栏导航中的数据库，首先修改 root 密码，再打开 phpMyAdmin（phpMyAdmin 默认用户名为 root）

新建数据库名`sspanel`

点击下面的链接下载 sspanel.sql 导入，然后拉到底部点击执行按钮：
https://files.re/file/sspanel.sql


# 站点设置
添加伪静态：
```
location / {
    try_files $uri $uri/ /index.php$is_args$args;
}
```

## 【可选】申请 Let's Encrypt 证书 开启 HTTPS 访问（使用 IP 访问的不能申请 SSL）

然后开启右上角的 强制HTTPS：

网站目录里的 运行目录 改为`/public`，保存

## SSPanel 配置
进入` config `目录，右键` .config.php.example `文件，重命名为` .config.php`


打开编辑` .config.php `文件，修改数据库密码即可，其他项目按照中文提示修改

最后，网站即可正常打开

# 其他设置
创建管理员：
```
php xcat createAdmin
```
按提示输入管理员邮箱与密码，然后按 y 确认：

# 添加计划任务
每日邮件：
```
php /www/wwwroot/sspanel/xcat sendDiaryMail
```

每日清理：
```
php -n /www/wwwroot/sspanel/xcat dailyjob
```

每分钟检查：
```
php /www/wwwroot/sspanel/xcat checkjob
```

每分钟同步：
```
php /www/wwwroot/sspanel/xcat syncnode
```

# 部署后端
登录面板，点击管理面板

添加节点

填写「节点名称」与「节点地址」，其他项目按提示填写，然后点击添加

节点添加成功后，牢记节点ID，稍后用到：

# 搭建后端

## 【可选】安装 BBR 加速（不支持 OpenVZ）：
```
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
```
## 【可选】安装 libsodium（更多加密方式）：
```
yum -y groupinstall "Development Tools"
wget https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz
tar xf libsodium-1.0.16.tar.gz && cd libsodium-1.0.16 
./configure && make -j2 && make install
echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf 
ldconfig
```
安装 shadowsocks-manyuser：
```
cd /root 
yum -y install python-setuptools wget unzip
easy_install pip
wget https://files.re/codes/shadowsocks.zip && unzip -q shadowsocks.zip
cd shadowsocks
pip install -r requirements.txt
cp apiconfig.py userapiconfig.py
cp config.json user-config.json
chmod +x run.sh stop.sh
```
关闭 CentOS 7 的防火墙并禁用：
```
systemctl stop firewalld.service
systemctl disable firewalld.service
```
编辑节点：
```
vi userapiconfig.py
```
按键盘 i 键，进入编辑模式

只需修改以下三项即可：
```
NODE_ID 是添加节点的 ID
WEBAPI_URL 填写前端面板的域名
WEBAPI_TOKEN 填写的是 /config/.config.php 配置文件内的 muKey
```

按键盘 esc 键退出编辑模式，输入 :wq 保存并退出。

调试运行：

`python server.py`
回显以下内容即对接成功：

Ctrl + c 退出调试。

后台运行：

`./run.sh`
