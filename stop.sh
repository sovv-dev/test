#!/bin/bash

echo "1. Очищаем старые правила и процессы..."
sudo killall nfqws 2>/dev/null
sudo iptables -t mangle -D OUTPUT -p tcp --dport 443 -j NFQUEUE --queue-num 200 --queue-bypass 2>/dev/null   
