#!/bin/sh

while true; do
    # 1. Volume (Direct icon + raw integer math)
    VOL_PCT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
    VOL="󰕾 ${VOL_PCT:-0}%"
    
    # 2. CPU 
    CPU_PCT=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print int(100 - $1)}')
    CPU="󰍛 ${CPU_PCT:-0}%"
    
    # 3. RAM & Free Memory (GiB Calculations)
    MEM_DATA=$(free -b | awk '/Mem:/ {print $2,$3,$7}')
    MEM_TOTAL=$(echo "$MEM_DATA" | awk '{printf "%.1f", $1/1024/1024/1024}')
    MEM_USED=$(echo "$MEM_DATA" | awk '{printf "%.1f", $2/1024/1024/1024}')
    MEM_FREE=$(echo "$MEM_DATA" | awk '{printf "%.1f", $3/1024/1024/1024}')
    RAM="󰘚 ${MEM_USED}/${MEM_TOTAL}GiB (󰗦 ${MEM_FREE}GiB free)"
    
    # 4. Date & Time
    DATE="󰸗 $(date +'%Y-%m-%d') 󱑒 $(date +'%I:%M %p')"
    
    # Combined output
    echo "$VOL   $CPU   $RAM   $DATE"
    
    sleep 2
done
