#!/bin/bash
# ==============================================
# Sample Tracking System — BPL/GLP Compliant
# Author: Victoria Djana
# Description: Biological sample tracking tool
# ==============================================

DB="lab_tracking.db"
LOG="tracking.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Logging function
log_action() {
echo "[$DATE] $1" >> "$LOG"
}

# Add a new sample
add_sample() {
local id="$1"
local type="$2"
local date="$3"

sqlite3 "$DB" "
INSERT INTO samples (sample_id, sample_type, reception_date, status)
VALUES ('$id', '$type', '$date', 'RECEIVED');
"
log_action "ADDED sample $id | type: $type | date: $date"
echo "✔ Sample $id registered successfully."
}

# Update sample status
update_status() {
local id="$1"
local status="$2"

sqlite3 "$DB" "
UPDATE samples SET status='$status', last_updated='$DATE'
WHERE sample_id='$id';
"
log_action "UPDATED sample $id | new status: $status"
echo "✔ Sample $id status updated to $status."
}

# Check sample status
check_status() {
local id="$1"
sqlite3 "$DB" "
SELECT sample_id, sample_type, reception_date, status, last_updated
FROM samples WHERE sample_id='$id';
"
}

# Export batch report
export_report() {
local batch="$1"
sqlite3 "$DB" "
SELECT * FROM samples WHERE batch_id='$batch';
" > "report_${batch}.csv"
log_action "EXPORTED report for batch $batch"
echo "✔ Report saved: report_${batch}.csv"
}

# Argument parser
case "$1" in
--add)
add_sample "$3" "$5" "$7"
;;
--status)
check_status "$3"
;;
--update)
update_status "$3" "$5"
;;
--report)
export_report "$3"
;;
*)
echo "Usage: bash tracking.sh [--add|--status|--update|--report]"
;;
esac
