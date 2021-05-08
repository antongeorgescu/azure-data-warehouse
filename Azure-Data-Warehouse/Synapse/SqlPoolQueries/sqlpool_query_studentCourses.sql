SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://loanstarlake.dfs.core.windows.net/loanstarfilesys/studentCourses.parquet',
        FORMAT='PARQUET'
    ) AS [result]