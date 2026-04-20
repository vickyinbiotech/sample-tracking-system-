-- ============================================
-- Sample Tracking Database — BPL/GLP Compliant
-- Author: Victoria Djana
-- ============================================

-- Main samples table
CREATE TABLE IF NOT EXISTS samples (
id INTEGER PRIMARY KEY AUTOINCREMENT,
sample_id TEXT NOT NULL UNIQUE,
sample_type TEXT NOT NULL,
batch_id TEXT,
reception_date TEXT NOT NULL,
status TEXT DEFAULT 'RECEIVED',
last_updated TEXT,
operator TEXT,
notes TEXT
);

-- Status history for full traceability
CREATE TABLE IF NOT EXISTS status_history (
id INTEGER PRIMARY KEY AUTOINCREMENT,
sample_id TEXT NOT NULL,
old_status TEXT,
new_status TEXT NOT NULL,
changed_at TEXT NOT NULL,
operator TEXT,
FOREIGN KEY (sample_id) REFERENCES samples(sample_id)
);

-- Batch table
CREATE TABLE IF NOT EXISTS batches (
batch_id TEXT PRIMARY KEY,
creation_date TEXT NOT NULL,
sample_count INTEGER DEFAULT 0,
status TEXT DEFAULT 'OPEN'
);

-- Example data (fictional)
INSERT INTO batches VALUES ('BATCH_2024_06', '2024-06-01', 3, 'CLOSED');

INSERT INTO samples VALUES
(1, 'ECH001', 'water', 'BATCH_2024_06', '2024-06-01', 'ARCHIVED', '2024-06-15', 'V.Djana', 'pH + ICP-MS'),
(2, 'ECH002', 'soil', 'BATCH_2024_06', '2024-06-01', 'ARCHIVED', '2024-06-15', 'V.Djana', 'Spectrophotometry'),
(3, 'ECH003', 'cereal', 'BATCH_2024_06', '2024-06-02', 'ARCHIVED', '2024-06-16', 'V.Djana', 'ICP-MS');
