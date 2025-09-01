-- Idempotent per-start checks
CREATE EXTENSION IF NOT EXISTS vector;

-- Ensure table exists
CREATE TABLE IF NOT EXISTS items (
  id SERIAL PRIMARY KEY,
  name TEXT,
  embedding vector(1536)
);

-- Optional: add columns/indexes if missing
-- ALTER TABLE items ADD COLUMN IF NOT EXISTS created_at timestamptz DEFAULT now();

-- Example: verify operator usage (no-op if table empty)
-- SELECT id FROM items ORDER BY embedding <-> '[0,0,0]' LIMIT 1;
