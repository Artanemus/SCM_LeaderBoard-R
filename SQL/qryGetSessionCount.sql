USE SwimClubMeet;

DECLARE @SDate AS DATETIME;
DECLARE @EDate AS DATETIME;
DECLARE @SwimClubID AS INTEGER;

SET @SDate = '2021-01-01';
SET @EDate = '2022-01-20';
SET @SwimClubID = 1;

WITH myCTE
AS (SELECT COUNT(*) AS RowsInView
    FROM [dbo].[Session]
    WHERE [Session].SessionStart >= @SDate
          AND [Session].SessionStart <= @EDate
          AND [Session].SwimClubID = @SwimClubID)
SELECT myCTE.RowsInView
FROM myCTE;

