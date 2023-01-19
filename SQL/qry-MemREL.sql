USE SwimClubMeet;
DECLARE @SeedDate AS DATETIME;
DECLARE @SDate AS DATETIME;
DECLARE @EDate AS DATETIME;
DECLARE @DoEvent AS BIT;
DECLARE @DoLockedSession AS BIT;

SET @SeedDate = '2021-08-01'; --:AGESEEDDATE;
SET @SDate = '2022-01-27'; -- :DTSTART;
SET @EDate = '2022-01-28'; -- :DTEND;
SET @DoEvent = 0;
SET @DoLockedSession = 1;

IF OBJECT_ID('tempdb..#tmp4', 'U') IS NOT NULL
    DROP TABLE #tmp4;

-- build a list of divisions with it's members
SELECT ScoreDivisionID,
       MemberID
INTO #tmp4
FROM ScoreDivision
    LEFT JOIN Member
        ON ScoreDivision.GenderID = Member.GenderID
WHERE dbo.SwimmerAge(@SeedDate, member.DOB) >= AgeFrom
      AND dbo.SwimmerAge(@SeedDate, member.DOB) <= AgeTo;

IF OBJECT_ID('tempdb..#tmp1', 'U') IS NOT NULL
    DROP TABLE #tmp1;

-- CALCULATE PLACE
SELECT ScoreDivisionID,
       Entrant.MemberID,
       Entrant.EntrantID,
       [Event].StrokeID,
       [Event].DistanceID,
       CASE @DoEvent
           WHEN 1 THEN
               dbo.RELEventPlace([Event].[EventID], Entrant.MemberID, #tmp4.ScoreDivisionID, @SeedDate)
           WHEN 0 THEN
               dbo.RELHeatPlace([HeatIndividual].[HeatID], Entrant.MemberID, ScoreDivisionID, @SeedDate)
           ELSE
               0
       END AS Place
INTO #tmp1
FROM #tmp4
    INNER JOIN Entrant
        ON #tmp4.MemberID = Entrant.MemberID
    INNER JOIN HeatIndividual
        ON Entrant.HeatID = HeatIndividual.HeatID
    INNER JOIN [Event]
        ON HeatIndividual.EventID = [Event].EventID
    INNER JOIN [Session]
        ON Event.SessionID = [Session].SessionID
WHERE Session.SessionStart >= @SDate
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

-- GATHER UP ALL THE EVENT TYPES AND CALCULATE A SUBTOTAL 
SELECT #tmp1.ScoreDivisionID,
       #tmp1.MemberID,
       #tmp1.DistanceID,
       #tmp1.StrokeID,
       SUM(dbo.EntrantScore(#tmp1.EntrantID, ScorePoints.Points)) AS SubTotal
INTO #tmp2
FROM #tmp1
    LEFT JOIN ScorePoints
        ON #tmp1.Place = ScorePoints.Place
GROUP BY #tmp1.ScoreDivisionID,
         #tmp1.MemberID,
         #tmp1.DistanceID,
         #tmp1.StrokeID;

IF OBJECT_ID('tempdb..#tmp3', 'U') IS NOT NULL
    DROP TABLE #tmp3;

-- CALCULATE TOTAL-SCORE
SELECT #tmp2.ScoreDivisionID,
       #tmp2.MemberID,
       SUM(#tmp2.SubTotal) AS TotalScore
INTO #tmp3
FROM #tmp2
GROUP BY #tmp2.ScoreDivisionID,
         #tmp2.MemberID;

-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT 
SELECT #tmp2.ScoreDivisionID,
       #tmp2.MemberID,
       #tmp2.DistanceID,
       #tmp2.StrokeID,
       #tmp3.TotalScore,
       #tmp2.SubTotal,
       SUBSTRING(CONCAT(FirstName, ' ', UPPER(LastName)), 0, 50) AS MemberNameStr,
       SUBSTRING(CONCAT(Distance.Caption, ' ', Stroke.Caption), 0, 50) AS DistStrokeStr,
       ScoreDivision.Caption AS DivisionStr,
       ScoreDivision.GenderID,
       ScoreDivision.AgeTo,
       Gender.Caption as GenderStr
FROM #tmp2
    INNER JOIN #tmp3
        ON #tmp2.ScoreDivisionID = #tmp3.ScoreDivisionID
           AND #tmp2.MemberID = #tmp3.MemberID
    INNER JOIN Member
        ON #tmp2.MemberID = Member.MemberID
    INNER JOIN Stroke
        ON #tmp2.StrokeID = Stroke.StrokeID
    INNER JOIN Distance
        ON #tmp2.DistanceID = Distance.DistanceID
    INNER JOIN ScoreDivision
        ON #tmp2.ScoreDivisionID = ScoreDivision.ScoreDivisionID
    INNER JOIN Gender
        ON Member.GenderID = Gender.GenderID
-- NOTE: final sort index applied in FireDAC 
ORDER BY #tmp2.MemberID;

DROP TABLE #tmp3;
DROP TABLE #tmp2;
DROP TABLE #tmp1;
DROP TABLE #tmp4;




