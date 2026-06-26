CREATE TABLE app.events_partitioned (
    event_id bigint NOT NULL,
    tenant_id integer NOT NULL,
    event_type text NOT NULL,
    payload jsonb NOT NULL,
    created_at timestamptz NOT NULL,
    PRIMARY KEY (event_id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE app.events_2026_01
    PARTITION OF app.events_partitioned
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

CREATE TABLE app.events_2026_02
    PARTITION OF app.events_partitioned
    FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
