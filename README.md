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
