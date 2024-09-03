#!/bin/bash

# Define the log files to be analyzed
LOG_FILES="/var/log/messages /var/log/syslog /var/log/secure /var/log/httpd/access_log /var/log/nginx/access.log"

#Define the patterns to find
PATTERNS="warn|error"

# Define the report file
REPORT_FILE="/tmp/log_analysis_report.txt"

# Get todays date in the logfile
TODAY=$(date +"%b %e")
# Clear report file if it exists
echo "" > "$REPORT_FILE"

# Start writing report in the  Analysis file
echo "Analyzing logs" >> "$REPORT_FILE"
echo "==============" >> "$REPORT_FILE"
echo "Date: $(date)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Start the analysis
for LOG_FILE in $LOG_FILES; do
        if [ -f "$LOG_FILE" ]; then
                echo "analyzing $LOG_FILE..." >> "$REPORT_FILE"
                echo "----------------------" >> "$REPORT_FILE"

                # Search for patters
                grep "$TODAY" "$LOG_FILE" | grep -Ei "$PATTERNS" | sort | uniq -c | sort -nr >> "$REPORT_FILE"

                echo "" >> "$REPORT_FILE"
        else
                echo "$LOG_FILE does not exist" >> "$REPORT_FILE"
                echo "" >> "$REPORT_FILE"
        fi
done

# Print completion of analysis
echo "Analysis completed and saved in $REPORT_FILE"
