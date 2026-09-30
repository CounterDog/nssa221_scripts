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

main() {
    # This will be the ONLY code that runs at the top level
    parse_arguments "$@"
    run_health_checks
    generate_report
}

main