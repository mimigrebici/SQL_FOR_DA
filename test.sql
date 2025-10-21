

CREATE OR REPLACE PROCEDURE procedure_name()
LANGUAGE plpgsql -- or other supported language like SQL
AS $$
DECLARE
    month_num INT := 1;
    table_name TEXT;
    sql_text TEXT;
BEGIN
    WHILE month_num <= 12 LOOP
        IF EXISTS (
            SELECT 1
            FROM job_postings_fact
            WHERE EXTRACT(MONTH FROM job_posted_date) = month_num
        ) THEN
            table_name := TRIM(LOWER(TO_CHAR((DATE '2000-01-01') + (month_num-1) * INTERVAL '1 month', 'Month')));
            sql_text := 'CREATE TABLE "' || table_name || '_job_postings" AS SELECT * FROM job_postings_fact WHERE EXTRACT(MONTH FROM job_posted_date) = ' || month_num;
            EXECUTE sql_text;
        END IF;
        month_num := month_num + 1;
    END LOOP;
END;
$$;

CALL procedure_name();