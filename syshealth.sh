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
