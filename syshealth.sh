#!/usr/bin/env bash
# ===============================================
# syshealth.sh - System Health & Log Analysis Toolkit
# Lab 3 - Refactoring into Functions
# Author: Jonathan Jiang
# Date: 2026-9-30
# ===============================================
# --- Thresholds (global, used by multiple functions) ---
CPU_THRESHOLD=75
MEM_THRESHOLD=85
DISK_THRESHOLD=85

print_status() {
    local status="$1"
    local message="$2"

    if [ "$status" = "OK" ]; then
        echo -e "\e[32m OK: $message\e[0m"
    else
        echo -e "\e[31m ALERT: $message\e[0m"
    fi
}

check_disk_usage() {
    local mount="$1"
    local pct threshold
    threshold="$DISK_THRESHOLD"

    if ! mountpoint -q "$mount" 2>/dev/null && [ "$mount" != "/" ]; then
        print_status "OK" "Mount point $mount does not exist on this system"
        return 0
    fi

    pct=$(df "$mount" | tail -1 | awk '{gsub("%",""); print $5}')

    if (( pct > threshold )); then
        print_status "ALERT" "Disk usage on $mount is ${pct}% (threshold ${threshold}%)"
        return 1
    else
        print_status "OK" "Disk usage on $mount is ${pct}%"
        return 0
    fi
}

check_memory_usage() {
    local pct threshold
    threshold="$MEM_THRESHOLD"
    pct=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')

    if (( pct > threshold )); then
        print_status "ALERT" "Memory usage is ${pct}% (threshold ${threshold}%)"
        return 1

    else
        print_status "OK" "Memory usage is ${pct}%"
        return 0
    fi
}
    
check_cpu_usage() {
    local pct threshold
    threshold="$CPU_THRESHOLD"
    pct=$(top -bn1 | grep '^%Cpu' | awk '{print 100 - $8}' | cut -d. -f1)
    
    if (( pct > threshold )); then
        print_status "ALERT" "CPU usage is ${pct}% (threshold ${threshold}%)"
        return 1

    else
        print_status "OK" "CPU usage is ${pct}%"
        return 0
    fi
}

main() {
    # This will be the ONLY code that runs at the top level
    # parse_arguments "$@"
    # run_health_checks
    # generate_report
    check_cpu_usage
    check_disk_usage
    check_memory_usage
    print_status "OK"
}

main