## Usefull commands
### 1. Close all ports except 22 with iptables:
```
iptables -A INPUT -p tcp -m tcp -m multiport ! --dports 22 -j DROP
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
