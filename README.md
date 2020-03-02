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
{ echo -ne "HTTP/1.0 200 OK\r\n\r\n"; cat index.html; } | nc -l -p 8080
```
### 8. Create SOCKS5 proxy based on GO and docker
```
//Through Host's default route
docker run --restart unless-stopped -d --name socks5 -p 1080:1080 -e PROXY_USER=<proxy_user> -e PROXY_PASSWORD=<proxy_password> serjs/go-socks5-proxy

// By setting custom default route (for example bypassing host's VPN)
docker run --restart unless-stopped --cap-add NET_ADMIN -d --name socks5 -p 1080:1080 -e PROXY_USER=<proxy_user> -e PROXY_PASSWORD=<proxy_password> serjs/go-socks5-proxy bash -c 'ip route del default && ip route add default via <default_route_address> && /socks5'
```

### 8. Create HTTP proxy based on Tinyproxy (C) and docker
```
docker run -d --name tinyproxy -p <port>:8888 dannydirect/tinyproxy:latest <ACL>

// For example
docker run -d --name tinyproxy -p 3128:8888 dannydirect/tinyproxy:latest ANY
```
### 9. Store Git password
```
git config --global credential.helper store
// then git pull...
```
### 10. Let Me Know (lmk) - Notifier for long running commands in shell ( put in ~/.bashrc )
```
lmk(){
    start=$(date +%s)
    "$@"

    if [ $? = 0 ];
    then
       ntfy -t "Success after $(($(date +%s) - start)) seconds." send "$(history|tail -n1|cut -c 12-)";
    else
       ntfy -t "Fail after $(($(date +%s) - start)) seconds." send "$(history|tail -n1|cut -c 12-)";
    fi
}
```
#### and execute commands by 
```
$ lmk docker-compose build
```

### 11. Remove files with sensitive information from Git repo
```
bfg --delete-files YOUR-FILE-WITH-SENSITIVE-DATA
```
More information [here](https://rtyley.github.io/bfg-repo-cleaner/)
