#!/usr/bin/env bash
# ===============================================
# syshealth.sh - System Health & Log Analysis Toolkit
# Lab 1 - Data Collector
# Author: Jonathan Jiang
# Date: $(date +%Y-%m-%d)
# ===============================================

# --- Variables and quoting demonstration ---
HOSTNAME=$(hostname)
CURRENT_DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "Hostname without quotes: $HOSTNAME" # works here but dangerous later
echo "Hostname with quotes: \"$HOSTNAME\"" # always do this

# Add a comment explaining the difference (required for marks):
# The difference between double quotation marks and no quotation marks is that, for arguments that contain spaces, Bash will separate an argument by the space and treat it as two separate arguments.
# For instance, for a hostname named "my computer", Bash will expand "echo $HOSTNAME" to "echo my computer". This is called wordsplitting.
# Double quotes prevent wordsplitting by wrapping them into a single string argument.

# --- System metrics collection ---
UPTIME=$(uptime -p)
DISK_USAGE=$(df -h / | tail -1)
MEMORY_USAGE=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
PROCESS_COUNT=$(ps -e | wc -l)