## Usefull commands
### 1. Close all ports except 80, 443 with iptables:
```
iptables -A INPUT -p tcp -m tcp -m multiport ! --dports 80,443 -j DROP
```
