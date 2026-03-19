#!/bin/bash

echo "1. Очищаем старые правила и процессы..."
sudo killall nfqws 2>/dev/null
sudo iptables -t mangle -D OUTPUT -p tcp --dport 443 -j NFQUEUE --queue-num 200 --queue-bypass 2>/dev/null

echo "2. Устанавливаем правила iptables..."
# Перенаправляем весь HTTPS в nfqws
sudo iptables -t mangle -A OUTPUT -p tcp --dport 443 -j NFQUEUE --queue-num 200 --queue-bypass

echo "3. Запускаем nfqws с РАБОЧЕЙ стратегией..."
sudo nfqws --qnum=200 --dpi-desync=multidisorder --dpi-desync-split-pos=midsld --user=root --daemon 
