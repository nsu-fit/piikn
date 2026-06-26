SET search_path = course_lab, public;

TRUNCATE issue_comments, issue_tickets, issue_projects RESTART IDENTITY CASCADE;

DO $$
BEGIN
    INSERT INTO issue_projects (code, name)
    VALUES ('CORE', 'Core platform');
EXCEPTION WHEN others THEN
    RAISE EXCEPTION 'valid project was rejected: %', SQLERRM;
END $$;

DO $$
BEGIN
    INSERT INTO issue_projects (code, name)
    VALUES ('bad-code', 'Invalid project');
    RAISE EXCEPTION 'invalid project code was accepted';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'ok: invalid project code rejected';
END $$;

DO $$
DECLARE
    v_project_id integer;
BEGIN
    SELECT project_id INTO v_project_id
    FROM issue_projects
    WHERE code = 'CORE';

    INSERT INTO issue_tickets
        (project_id, title, status, priority, external_key)
    VALUES
        (v_project_id, 'Add smoke tests', 'open', 3, 'CORE-1');
EXCEPTION WHEN others THEN
    RAISE EXCEPTION 'valid ticket was rejected: %', SQLERRM;
END $$;

DO $$
DECLARE
    v_project_id integer;
BEGIN
    SELECT project_id INTO v_project_id
    FROM issue_projects
    WHERE code = 'CORE';

    INSERT INTO issue_tickets
        (project_id, title, status, priority)
    VALUES
        (v_project_id, 'Invalid priority', 'open', 9);
    RAISE EXCEPTION 'invalid priority was accepted';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'ok: invalid priority rejected';
END $$;

DO $$
DECLARE
    v_project_id integer;
BEGIN
    SELECT project_id INTO v_project_id
    FROM issue_projects
    WHERE code = 'CORE';

    INSERT INTO issue_tickets
        (project_id, title, status, priority, closed_at)
    VALUES
        (v_project_id, 'Closed without status', 'open', 2, current_timestamp);
    RAISE EXCEPTION 'open ticket with closed_at was accepted';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'ok: inconsistent closed_at rejected';
END $$;

DO $$
DECLARE
    v_project_id integer;
BEGIN
    SELECT project_id INTO v_project_id
    FROM issue_projects
    WHERE code = 'CORE';

    INSERT INTO issue_tickets
        (project_id, title, status, priority)
    VALUES
        (v_project_id, 'Closed without timestamp', 'closed', 2);
    RAISE EXCEPTION 'closed ticket without closed_at was accepted';
EXCEPTION
    WHEN check_violation THEN
        RAISE NOTICE 'ok: closed ticket without closed_at rejected';
END $$;

DO $$
DECLARE
    v_ticket_id integer;
BEGIN
    SELECT ticket_id INTO v_ticket_id
    FROM issue_tickets
    WHERE external_key = 'CORE-1';

    INSERT INTO issue_comments (ticket_id, author, body)
    VALUES (v_ticket_id, 'teacher', 'Looks reproducible');
EXCEPTION WHEN others THEN
    RAISE EXCEPTION 'valid comment was rejected: %', SQLERRM;
END $$;

DO $$
BEGIN
    INSERT INTO issue_comments (ticket_id, author, body)
    VALUES (999999, 'teacher', 'Missing ticket');
    RAISE EXCEPTION 'comment for missing ticket was accepted';
EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'ok: comment for missing ticket rejected';
END $$;

SELECT
    (SELECT count(*) FROM issue_projects) AS project_count,
    (SELECT count(*) FROM issue_tickets) AS ticket_count,
    (SELECT count(*) FROM issue_comments) AS comment_count;
