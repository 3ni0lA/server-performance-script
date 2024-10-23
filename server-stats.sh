#!/bin/bash

# Function to get total CPU usage
get_cpu_usage() {
    echo "Total CPU Usage:"
    # The 'mpstat' command gives CPU usage statistics. 
    # 'awk' extracts the idle CPU percentage and calculates the used percentage.
    if command -v mpstat &> /dev/null; then
        mpstat | awk '$12 ~ /[0-9.]+/ { print 100 - $12"%"}'
    else
        # Fallback to calculating CPU usage via /proc/stat
        cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
        cpu_usage=$(echo "100 - $cpu_idle" | bc)
        echo "$cpu_usage%"
    fi
    echo
}

# Function to get total memory usage
get_memory_usage() {
    echo "Total Memory Usage:"
    # 'free -m' provides memory usage in MB. We use 'awk' to extract and calculate percentages.
    free -m | awk 'NR==2{printf "Used: %sMB / %sMB (%.2f%%)\n", $3,$2,$3*100/$2}'
    echo
}

# Function to get total disk usage
get_disk_usage() {
    echo "Total Disk Usage:"
    # 'df -h' shows disk usage in human-readable form, the first line after headers is the total usage.
    df -h --total | grep 'total' | awk '{printf "Used: %s / %s (%s)\n", $3, $2, $5}'
    echo
}

# Function to get the top 5 processes by CPU usage
get_top_cpu_processes() {
    echo "Top 5 Processes by CPU Usage:"
    # 'ps' command to list top 5 processes by CPU usage
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
    echo
}

# Function to get the top 5 processes by memory usage
get_top_memory_processes() {
    echo "Top 5 Processes by Memory Usage:"
    # 'ps' command to list top 5 processes by memory usage
    ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6
    echo
}

# Function to get OS version and other system info (stretch goal)
get_system_info() {
    echo "System Information:"
    # 'uname' provides kernel and OS version information
    uname -a
    echo
}

# Function to get system uptime (stretch goal)
get_uptime() {
    echo "System Uptime:"
    # 'uptime' command gives the current system uptime
    uptime -p
    echo
}

# Function to get load average (stretch goal)
get_load_average() {
    echo "Load Average:"
    # 'uptime' or 'cat /proc/loadavg' gives the load average
    uptime | awk -F'load average:' '{ print $2 }'
    echo
}

# Function to get logged-in users (stretch goal)
get_logged_in_users() {
    echo "Logged-in Users:"
    # 'who' command lists currently logged-in users
    who
    echo
}

# Function to get failed login attempts (stretch goal)
get_failed_login_attempts() {
    echo "Failed Login Attempts:"
    # Extract failed login attempts from the system logs
    grep "Failed password" /var/log/auth.log | wc -l 2>/dev/null || echo "Log file not accessible."
    echo
}

# Main function to run all checks
main() {
    echo "===== Server Performance Stats ====="
    get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_top_cpu_processes
    get_top_memory_processes
    get_system_info
    get_uptime
    get_load_average
    get_logged_in_users
    get_failed_login_attempts
    echo "===================================="
}

# Run the script
main
