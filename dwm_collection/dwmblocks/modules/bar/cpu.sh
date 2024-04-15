#!/usr/bin/bash

icon=🧠

# Get CPU statistics from /proc/stat
cpu_stat=$(cat /proc/stat | grep '^cpu ')

# Extract individual CPU times
cpu_user=$(echo "$cpu_stat" | awk '{print $2}')
cpu_nice=$(echo "$cpu_stat" | awk '{print $3}')
cpu_system=$(echo "$cpu_stat" | awk '{print $4}')
cpu_idle=$(echo "$cpu_stat" | awk '{print $5}')
cpu_iowait=$(echo "$cpu_stat" | awk '{print $6}')
cpu_irq=$(echo "$cpu_stat" | awk '{print $7}')
cpu_softirq=$(echo "$cpu_stat" | awk '{print $8}')
cpu_steal=$(echo "$cpu_stat" | awk '{print $9}')
cpu_guest=$(echo "$cpu_stat" | awk '{print $10}')
cpu_guest_nice=$(echo "$cpu_stat" | awk '{print $11}')

# Calculate total CPU time
total_cpu_time=$((cpu_user + cpu_nice + cpu_system + cpu_idle + cpu_iowait + cpu_irq + cpu_softirq + cpu_steal + cpu_guest + cpu_guest_nice))

# Calculate idle CPU time
idle_cpu_time=$((cpu_idle + cpu_iowait))

# Calculate CPU usage percentage
cpu_usage=$((100 * (total_cpu_time - idle_cpu_time) / total_cpu_time))

temp=$($(dirname "$0")/cpu_temp.sh)

printf "$icon $cpu_usage%% $temp"
