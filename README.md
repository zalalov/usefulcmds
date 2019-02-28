## Usefull commands
### 1. IPTABLES:
```
// Close all ports except 22
iptables -A INPUT -p tcp -m tcp -m multiport ! --dports 22 -j DROP

// PPTP CONFIGURATION
// Accept all connection to 1723 port (pptp)
iptables -A INPUT -p tcp -m tcp --dport 1723 -j ACCEPT
// FORWARD RULES BETWEEN eth and ppp
iptables -A FORWARD -i eth0 -o ppp0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i ppp0 -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o ppp1 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i ppp1 -o eth0 -j ACCEPT
```

### 2. Check web project for malicious code:
```
wget git.io/mwscan.txt
grep -Erlf mwscan.txt /check/dir/
```

### 3. Docker cleanup
```
docker stop $(docker ps -q)
docker rm $(docker ps -q --all)
docker rmi $(docker images -q)
cd /var/lib/docker/aufs
rm -rf *
/etc/init.d/docker restart
```

### 4. MTProxy
```
docker run -d -p4443:443 -v proxy-config:<CONFIG_PATH> -e SECRET=<SECRET> --name mtproxy telegrammessenger/proxy:latest
```

### 5. Create Linux SWAP partition
```
# Create file for SWAP partition
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
# Mark file as a SWAP
sudo mkswap /swapfile
# Enable SWAP file
sudo swapon /swapfile
# Backup fstab configuration
sudo cp /etc/fstab /etc/fstab.bak
# Make SWAP partition permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### 6. OpenVPN
```
// Installing OpenVPN and configure 
wget git.io/vpn —no-check-certificate -O openvpn-install.sh; bash openvpn-install.sh
// FORWARD RULES BETWEEN eth and tun - run after installing openvpn to walk to internet
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o tun0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i tun0 -o eth0 -j ACCEPT
```
### 7. One-line bash webserver which responds with selected static HTML page
```
$ { echo -ne "HTTP/1.0 200 OK\r\n\r\n"; cat index.html; } | nc -l -p 8080
```
