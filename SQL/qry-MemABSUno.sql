USE SwimClubMeet;
DECLARE @SDate AS DATETIME;
DECLARE @EDate AS DATETIME;
DECLARE @DoEvent AS BIT;
DECLARE @DoLockedSession AS BIT;

SET @SDate = '2022-02-10'; -- :DTSTART;
SET @EDate = '2022-02-10'; -- :DTEND;
SET @DoEvent = 0;
SET @DoLockedSession = 1;

-- NOT REQUIRED ... 
-- Prior to calling here 
-- End date has been recoded to be one hour more than start date.

-- Midnight floor of current date
SET @SDate = CONVERT(DATETIME, DATEDIFF(DAY, 0, @SDate))
-- Ceiling
SET @EDate = CONVERT(DATETIME, DATEDIFF(DAY, 0, DATEADD(d, 1, @EDate)))

IF OBJECT_ID('tempdb..#tmp1', 'U') IS NOT NULL
    DROP TABLE #tmp1;

-- CALCULATE PLACE
SELECT Entrant.MemberID,
       Entrant.EntrantID,
       Entrant.RaceTime,
       [Event].StrokeID,
       [Event].DistanceID,
       [Event].Caption AS EventDetailStr, 
       CASE @DoEvent
           WHEN 1 THEN
               dbo.ABSEventPlace([Event].[EventID], Entrant.MemberID)
           WHEN 0 THEN
               dbo.ABSHeatPlace([HeatIndividual].[HeatID], Entrant.MemberID)
           ELSE
               0
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
                                        END
                                       );

IF OBJECT_ID('tempdb..#tmp2', 'U') IS NOT NULL
    DROP TABLE #tmp2;

-- CACLUATE A SCORE BASED ON PLACE 
SELECT #tmp1.StrokeID,
       #tmp1.DistanceID,
       #tmp1.EntrantID,
       #tmp1.MemberID,
       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Score
INTO #tmp2
FROM #tmp1
    LEFT JOIN ScorePoints
        ON #tmp1.Place = ScorePoints.Place

IF OBJECT_ID('tempdb..#tmp3', 'U') IS NOT NULL
    DROP TABLE #tmp3;

-- CALCULATE TOTAL-SCORE
SELECT #tmp2.MemberID,
       SUM(#tmp2.Score) AS TotalScore
INTO #tmp3
FROM #tmp2
GROUP BY #tmp2.MemberID;

-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT 
SELECT #tmp2.StrokeID,
       #tmp2.DistanceID,
       Member.GenderID,
       Member.MemberID,
       Gender.Caption,
       SUBSTRING(CONCAT(Member.FirstName, ' ', UPPER(Member.LastName)), 0, 50) AS MemberNameStr,
       SUBSTRING(CONCAT(Distance.Caption, ' ', Stroke.Caption), 0, 50) AS DistStrokeStr,
       dbo.SwimTimeToString(#tmp1.RaceTime) AS RaceTime,
       #tmp1.Place,
       #tmp2.Score,
       #tmp3.TotalScore,
       #tmp1.EventDetailStr
FROM #tmp2
    INNER JOIN #tmp1
        ON #tmp2.EntrantID = #tmp1.EntrantID
    INNER JOIN Member
        ON #tmp1.MemberID = Member.MemberID
    INNER JOIN #tmp3
        ON #tmp1.MemberID = #tmp3.MemberID
    INNER JOIN Stroke
        ON #tmp2.StrokeID = Stroke.StrokeID
    INNER JOIN Distance
        ON #tmp2.DistanceID = Distance.DistanceID
    INNER JOIN Gender
        ON Member.GenderID = Gender.GenderID

-- NOTE: final sort index applied in FireDAC        
ORDER BY Member.MemberID DESC;

DROP TABLE #tmp3;
DROP TABLE #tmp2;
DROP TABLE #tmp1;




