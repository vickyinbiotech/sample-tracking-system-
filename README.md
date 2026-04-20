# Sample Tracking System — BPL/GLP Compliant

Biological sample tracking system developed under Linux (Bash/Shell + SQL).
Designed to ensure full traceability across the analytical workflow in a BPL-accredited laboratory.

## Features
- Sample registration and unique ID assignment
- Status tracking at each stage (reception → analysis → archiving)
- SQL database for BPL compliance monitoring
- Automated logging with timestamps
- Exportable reports per batch

## Project Structure
```
sample-tracking-system/
├── README.md
├── tracking.sh # Main tracking script
├── database.sql # Database schema
└── data/
└── samples_example.csv # Example dataset (fictional data)
```

## Stack
- Language : Bash/Shell, SQL
- Environment : Linux (Ubuntu)
- Standard : BPL/GLP compliant workflow

## Context
Developed as part of a bioinformatics internship focused on
laboratory quality management and sample traceability.

## Usage
```bash
# Initialize the database
sqlite3 lab_tracking.db < database.sql

# Register a new sample
bash tracking.sh --add --id "ECH001" --type "water" --date "2024-06-01"

# Check sample status
bash tracking.sh --status --id "ECH001"

# Export batch report
bash tracking.sh --report --batch "BATCH_2024_06"
