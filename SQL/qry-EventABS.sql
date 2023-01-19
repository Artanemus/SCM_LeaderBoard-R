USE SwimClubMeet;
DECLARE @SDate AS DATETIME;
DECLARE @EDate AS DATETIME;
DECLARE @DoEvent AS BIT;
DECLARE @DoLockedSession AS BIT;

SET @SDate = '2022-01-27'; -- :DTSTART;
SET @EDate = '2022-01-28'; -- :DTEND;
SET @DoEvent = 1;
SET @DoLockedSession = 1;

IF OBJECT_ID('tempdb..#tmp1', 'U') IS NOT NULL
    DROP TABLE #tmp1;

-- CALCULATE PLACE
SELECT Entrant.MemberID,
       Entrant.EntrantID,
       [Event].StrokeID,
       [Event].DistanceID,
       CASE @DoEvent
           WHEN 1 THEN
               dbo.ABSEventPlace([Event].[EventID], Entrant.MemberID)
               WHEN 0 THEN
               dbo.ABSHeatPlace([HeatIndividual].[HeatID], Entrant.MemberID)
           ELSE 0
       END AS Place
INTO #tmp1
FROM Entrant
    INNER JOIN HeatIndividual
        ON Entrant.HeatID = HeatIndividual.HeatID
    INNER JOIN [Event]
        ON HeatIndividual.EventID = [Event].EventID
    INNER JOIN [Session]
        ON [Event].SessionID = [Session].SessionID
WHERE [Session].SessionStart >= @SDate
      AND [Session].SessionStart <= @EDate
      AND Entrant.MemberID IS NOT NULL
      AND [Session].SessionStatusID <= (CASE
                                           WHEN @DoLockedSession = 1 THEN
                                               2
                                           ELSE
                                               1
                                       END); 

IF OBJECT_ID('tempdb..#tmp2', 'U') IS NOT NULL
    DROP TABLE #tmp2;

-- CALCULATE POINTS
SELECT #tmp1.StrokeID,
       #tmp1.DistanceID,
       #tmp1.MemberID,
       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Points
INTO #tmp2
FROM #tmp1
    LEFT JOIN ScorePoints
        ON #tmp1.Place = ScorePoints.Place
ORDER BY MemberID ASC;

IF OBJECT_ID('tempdb..#tmp3', 'U') IS NOT NULL
    DROP TABLE #tmp3;

-- CALCULATE TOTAL-SCORE
SELECT #tmp2.MemberID,
       #tmp2.StrokeID,
       #tmp2.DistanceID,
       SUM(#tmp2.Points) AS TotalScore
INTO #tmp3
FROM #tmp2
GROUP BY #tmp2.MemberID,
         #tmp2.StrokeID,
         #tmp2.DistanceID;

-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT 
SELECT #tmp3.StrokeID,
       #tmp3.DistanceID,
       #tmp3.TotalScore,
       SUBSTRING(CONCAT(FirstName, ' ', UPPER(LastName)), 0, 50) AS MemberNameStr,
       SUBSTRING(CONCAT(Distance.Caption, ' ', Stroke.Caption), 0, 50) AS DistStrokeStr,
       Gender.GenderID,
       Gender.Caption AS GenderStr
FROM #tmp3
    INNER JOIN Member
        ON #tmp3.MemberID = Member.MemberID
    INNER JOIN Stroke
        ON #tmp3.StrokeID = Stroke.StrokeID
    INNER JOIN Distance
        ON #tmp3.DistanceID = Distance.DistanceID
    INNER JOIN Gender
        ON Member.GenderID = Gender.GenderID
ORDER BY StrokeID ASC,
         DistanceID ASC;

DROP TABLE #tmp3;
DROP TABLE #tmp2;
DROP TABLE #tmp1;




