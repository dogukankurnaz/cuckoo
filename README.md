# Cuckoo Sandbox!
**Language:**  
[![Flag: United Kingdom on Sony Playstation ](https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/60/sony/336/flag-united-kingdom_1f1ec-1f1e7.png)](https://github.com/dogukankurnaz/cuckoo)

Cuckoo Sandbox is an open source Malware analysis system. It does this in an isolated environment and gives you a comprehensive report.
Just follow the necessary steps to automatically install Cuckoo Sandbox on your own personal device or server.


# First Steps
Don't forget to take a snapshot backup before you start.

I have used Virtualbox for testing.

OS: Ubuntu 18.04 LTS

my username:cuckoo

my machine name:cuckoo-VirtualBox

Very Important! :Extended Feature "**Enable Nested VT-x/AMD-V**" is enabled in the Processor.

![](https://i.hizliresim.com/6apjynl.png)





```console
cuckoo@cuckoo-VirtualBox:~$ git clone https://github.com/dogukankurnaz/cuckoo.git
cuckoo@cuckoo-VirtualBox:~$ cd cuckoo
cuckoo@cuckoo-VirtualBox:~/Desktop/cuckoo$ ls
cuckoo_pre.sh  cuckoo_virtualmachine.sh  README.md  virtualenvwrapper.sh
cuckoo@cuckoo-VirtualBox:~/Desktop/cuckoo$ find -type f -name '*.sh' -exec chmod +x {} +
```



## ./cuckoo_pre.sh

```console
cuckoo@cuckoo-VirtualBox:~$ ./cuckoo_pre.sh
```
![](https://i.hizliresim.com/2y34dji.png)
![enter image description here](https://i.hizliresim.com/heeqi5h.png)
## ./virtualenvwrapper.sh

```console
cuckoo@cuckoo-VirtualBox:~$  ./virtualenvwrapper.sh
```

![](https://i.hizliresim.com/1i1dp2v.png)



![](https://i.hizliresim.com/3fk9hnw.png)

```console
cuckoo@cuckoo-VirtualBox:~$ source ~/.bashrc
cuckoo@cuckoo-VirtualBox:~$ mkvirtualenv -p python2.7 cuckoo-test
cuckoo@cuckoo-VirtualBox:~$ pip install -U pip setuptools
cuckoo@cuckoo-VirtualBox:~$ pip install -U cuckoo
```

## ./cuckoo_virtualmachine.sh

```console
cuckoo@cuckoo-VirtualBox:~$  ./cuckoo_virtualmachine.sh
```


![](https://i.hizliresim.com/akbktet.png)
![enter image description here](https://i.hizliresim.com/ro8ne26.png)

## Configuration

We learn the interface name with the ifconfig, command. My device's is enp0s3.


```console
cuckoo@cuckoo-VirtualBox:~$ ifconfig
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::b36b:4516:9694:c5cb  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:78:dd:64  txqueuelen 1000  (Ethernet)
        RX packets 3433080  bytes 5161919233 (5.1 GB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 861572  bytes 52237366 (52.2 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 4185  bytes 1123311 (1.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 4185  bytes 1123311 (1.1 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vboxnet0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.56.1  netmask 255.255.255.0  broadcast 192.168.56.255
        inet6 fe80::800:27ff:fe00:0  prefixlen 64  scopeid 0x20<link>
        ether 0a:00:27:00:00:00  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1171  bytes 119400 (119.4 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```

your interface name=**enp0s3** (My Device)
We replace the part that says with the interface name of our own device.
```console
cuckoo@cuckoo-VirtualBox:~$ vmcloak list vms
cuckoo@cuckoo-VirtualBox:~$ sudo sysctl -w net.ipv4.conf.vboxnet0.forwarding=1
(if your network interface is different change me!)
cuckoo@cuckoo-VirtualBox:~$ sudo sysctl -w net.ipv4.conf.enp0s3.forwarding=1 
```

![enter image description here](https://i.hizliresim.com/d5ax4n6.png)

```console
cuckoo@cuckoo-VirtualBox:~$ sudo nano /etc/sysctl.conf
```
![](https://i.hizliresim.com/guo0rul.png)

```console
cuckoo@cuckoo-VirtualBox:~$ sudo iptables -t nat -A POSTROUTING -o enp0s3 -s 192.168.56.0/24 -j MASQUERADE
cuckoo@cuckoo-VirtualBox:~$ sudo iptables -P FORWARD DROP
cuckoo@cuckoo-VirtualBox:~$ sudo iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
cuckoo@cuckoo-VirtualBox:~$ sudo iptables -A FORWARD -s 192.168.56.0/24 -j ACCEPT
```

![](https://i.hizliresim.com/4mcgjk1.png)

```console
cuckoo@cuckoo-VirtualBox:~$ cuckoo init
```
![](https://i.hizliresim.com/7xmxm6i.png)

```console
(cuckoo-test) cuckoo@cuckoo-VirtualBox:/$ cd /home/cuckoo/
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~$ ls -la
total 120
drwxr-xr-x 18 cuckoo cuckoo 4096 Oca 18 20:25 .
drwxr-xr-x  3 root   root   4096 Kas 30 22:50 ..
-rw-r--r--  1 cuckoo cuckoo  220 Kas 30 22:50 .bash_logout
-rw-r--r--  1 cuckoo cuckoo 4256 Oca 18 00:17 .bashrc
drwx------ 15 cuckoo cuckoo 4096 Oca 18 00:17 .cache
drwx------ 12 cuckoo cuckoo 4096 Oca 18 00:05 .config
drwxrwxr-x 17 cuckoo cuckoo 4096 Oca 18 20:25 .cuckoo
drwxr-xr-x  4 cuckoo cuckoo 4096 Oca 18 01:02 Desktop
drwxr-xr-x  2 cuckoo cuckoo 4096 Kas 30 22:58 Documents
drwxr-xr-x  2 cuckoo cuckoo 4096 Kas 30 22:58 Downloads
-rw-r--r--  1 cuckoo cuckoo 8980 Kas 30 22:50 examples.desktop
drwx------  3 cuckoo cuckoo 4096 Kas 30 22:57 .gnupg
-rw-------  1 cuckoo cuckoo  720 Kas 30 23:19 .ICEauthority
drwx------  5 cuckoo cuckoo 4096 Oca 18 00:17 .local
drwx------  5 cuckoo cuckoo 4096 Kas 30 23:00 .mozilla
drwxr-xr-x  2 cuckoo cuckoo 4096 Kas 30 22:58 Music
drwxr-xr-x  2 cuckoo cuckoo 4096 Kas 30 22:58 Pictures
-rw-r--r--  1 cuckoo cuckoo  807 Kas 30 22:50 .profile
drwxr-xr-x  2 cuckoo cuckoo 4096 Kas 30 22:58 Public
-rw-r--r--  1 cuckoo cuckoo    0 Oca 17 23:55 .sudo_as_admin_successful
drwxr-xr-x  2 cuckoo cuckoo 4096 Kas 30 22:58 Templates
-rw-r-----  1 cuckoo cuckoo    5 Kas 30 23:19 .vboxclient-clipboard.pid
-rw-r-----  1 cuckoo cuckoo    5 Kas 30 23:19 .vboxclient-display-svga-x11.pid
-rw-r-----  1 cuckoo cuckoo    5 Kas 30 23:19 .vboxclient-draganddrop.pid
-rw-r-----  1 cuckoo cuckoo    5 Kas 30 23:19 .vboxclient-seamless.pid
drwxr-xr-x  2 cuckoo cuckoo 4096 Kas 30 22:58 Videos
drwxrwxr-x  3 cuckoo cuckoo 4096 Oca 18 00:18 .virtualenvs
drwxr-xr-x  6 root   root   4096 Oca 18 01:17 .vmcloak

```

```console
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~$ cd .cuckoo/
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~/.cuckoo$ ls
agent     conf         elasticsearch  log      pidfiles    storage  supervisord       web        yara
analyzer  distributed  __init__.py    monitor  signatures  stuff    supervisord.conf  whitelist
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~/.cuckoo$ cuckoo community
```
![](https://i.hizliresim.com/5b9urf7.png)

Write your own username where it says "cuckoo". The username of my device that I set up is **cuckoo.**
```console
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~$ cuckoo rooter --sudo --group cuckoo 
```

![](https://i.hizliresim.com/w8hkbje.png)

Open new terminal.

```console
cuckoo@cuckoo-VirtualBox:~$ workon cuckoo-test
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~$ cd /.cuckoo/con
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~/.cuckoo/conf$ while read -r vm ip; do cuckoo machine --add $vm $ip; done < <(vmcloak list vms)
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~/.cuckoo/conf$ nano virtualbox.conf
```
![](https://i.hizliresim.com/mtdk93z.png)
![](https://i.hizliresim.com/4vtjydj.png)

Press "CTRL + X" and save "Y".


```console
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~/.cuckoo/conf$ nano routing.conf 
```
Type own network interface (type ifconfig command to find out)

![](https://i.hizliresim.com/dnc0dxy.png)

Press "CTRL + X" and save "Y".


```console
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~/.cuckoo/conf$ nano reporting.conf
```


![enter image description here](https://i.hizliresim.com/arokn7y.png)

```console
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~/.cuckoo/conf$ cuckoo
```

![](https://i.hizliresim.com/2wopf7w.png)


Open new terminal and change IP address.
```console
(cuckoo-test) cuckoo@cuckoo-VirtualBox:~/.cuckoo/conf$ cuckoo web --host 10.0.2.15 --port 8080
```
![enter image description here](https://i.hizliresim.com/ddgy2wx.png)

Open the browser.

![enter image description here](https://i.hizliresim.com/9mltn4h.png)

Congratulations! That's all :) 

Best Regards,
dogukaN
