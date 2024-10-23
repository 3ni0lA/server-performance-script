# Requirements
You are required to write a script `server-stats.sh` that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

- Total CPU usage
- Total memory usage (Free vs Used including percentage)
- Total disk usage (Free vs Used including percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage

Stretch goal: Feel free to optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.

## Features:
- Total CPU usage: Uses mpstat if available, otherwise falls back to top.
- Total memory usage: Uses the free -m command to display used vs free memory.
- Total disk usage: Displays total disk usage using df -h.
- Top 5 processes by CPU usage: Uses ps to list the top 5 CPU-intensive processes.
- Top 5 processes by memory usage: Uses ps to list the top 5 memory-intensive processes.

## Stretch goals:

 - OS version and system information: Extracted using uname -a.
 - System uptime: Displays human-readable uptime with uptime -p.
 - Load average: Extracts the system load average using uptime.
 - Logged-in users: Lists logged-in users using who.
 - Failed login attempts: Counts failed login attempts from /var/log/auth.log (on systems where this log exists and is accessible).
 
## How to run:
Save the script as `server-stats.sh`.
Give it executable permissions: `chmod +x server-stats.sh`.
Run the script: `./server-stats.sh`.

# This script provides a snapshot of the server’s performance and additional useful information for system monitoring.

# Projects url: https://roadmap.sh/projects/server-stats
