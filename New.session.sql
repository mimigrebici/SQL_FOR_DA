-- PostgreSQL: drop all tables whose name contains the literal substring '_job_postings'
DO $$
DECLARE
    rec RECORD;
    found BOOLEAN := FALSE;
BEGIN
    FOR rec IN
        SELECT schemaname, tablename
        FROM pg_catalog.pg_tables
        WHERE tablename LIKE '%\_job_postings%' ESCAPE '\'
            AND schemaname NOT IN ('pg_catalog','information_schema')
    LOOP
        found := TRUE;
        BEGIN
            EXECUTE format('DROP TABLE IF EXISTS %I.%I;', rec.schemaname, rec.tablename);
            RAISE NOTICE 'Dropped %.%', rec.schemaname, rec.tablename;
        EXCEPTION WHEN OTHERS THEN
            RAISE WARNING 'Failed to drop %.%: %', rec.schemaname, rec.tablename, SQLERRM;
        END;
    END LOOP;

    IF NOT found THEN
        RAISE NOTICE 'No tables found matching ''_job_postings''.';
    END IF;
END
$$ LANGUAGE plpgsql;
