SELECT
    TOP 100 *
FROM
    OPENROWSET(
            BULK '/loanstarfilesys/*Courses.parquet',
            DATA_SOURCE = 'LoanStarLake',
            FORMAT='PARQUET'
    ) AS [result]