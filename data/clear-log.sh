#! bin/bash

echo "Total space occupied by /var/log: "
du -sh /var/log

# Check if the "exec" parameter was passed
if [ "$1" == "exec" ]; then
    exec_mode=true
    echo "Running in deletion mode..."
else
    exec_mode=false
    echo "Dry run: to actually delete the files, run the script with the 'exec' parameter."
fi

# Find and display the space occupied by files older than a week
logs=$(sudo find /var/log -type f -mtime +7)
total_size=0

echo "Log files found:"
for file in $logs; do
    size=$(sudo du -k "$file" | cut -f1)
    total_size=$((total_size + size))
    echo "$file - $(du -h "$file" | cut -f1)"
    # If in exec mode, delete the file
    if [ "$exec_mode" = true ]; then
        sudo rm -f "$file"
    fi
done

# Convert total_size from KB to MB
total_size_mb=$(echo $total_size | awk '{printf "%.2f MB\n", $1/1024}')

if [ "$exec_mode" = true ]; then
    echo "Total space recovered: $total_size_mb"
else
    echo "Total space recoverable: $total_size_mb"
    echo "To actually delete the files, run the script with the 'exec' parameter."
fi
