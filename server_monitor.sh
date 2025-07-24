#!/bin/bash

# Server Monitoring Script

# Set thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

echo "------ Server Monitoring Report ------"
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "--------------------------------------"

# CPU Usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
cpu_usage=${cpu_usage%.*} # remove decimal

echo "CPU Usage: $cpu_usage%"

if [ "$cpu_usage" -ge "$CPU_THRESHOLD" ]; then
    echo "⚠️  High CPU Usage!"
fi

# Memory Usage
mem_used=$(free | awk '/Mem/ {printf("%.0f", $3/$2 * 100)}')
echo "Memory Usage: $mem_used%"

if [ "$mem_used" -ge "$MEM_THRESHOLD" ]; then
    echo "⚠️  High Memory Usage!"
fi

# Disk Usage
disk_used=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage on / : $disk_used%"

if [ "$disk_used" -ge "$DISK_THRESHOLD" ]; then
    echo "⚠️  High Disk Usage!"
fi

# Uptime
echo "Uptime: $(uptime -p)"

# Check nginx status
if systemctl is-active --quiet nginx; then
    echo "nginx is running ✅"
else
    echo "nginx is not running ❌"
fi

# Check apache2 status
if systemctl is-active --quiet apache2; then
    echo "apache2 is running ✅"
else
    echo "apache2 is not running ❌"
fi

echo "--------------------------------------"
