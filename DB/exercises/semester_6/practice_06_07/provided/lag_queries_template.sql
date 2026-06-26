-- Primary-side examples.
SELECT pg_current_wal_lsn() AS primary_current_wal_lsn;

SELECT
    application_name,
    state,
    sent_lsn,
    write_lsn,
    flush_lsn,
    replay_lsn,
    write_lag,
    flush_lag,
    replay_lag
FROM pg_stat_replication;

-- Replica-side examples, if a live replica is available.
SELECT
    pg_last_wal_receive_lsn() AS replica_receive_lsn,
    pg_last_wal_replay_lsn() AS replica_replay_lsn,
    pg_last_xact_replay_timestamp() AS last_replay_timestamp;
