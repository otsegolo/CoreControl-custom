-- Migration: Add min_downtime_seconds to application table
ALTER TABLE application ADD COLUMN min_downtime_seconds INTEGER;
