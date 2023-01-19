USE SwimClubMeet;
DECLARE @SeedDate AS DATETIME;
DECLARE @SDate AS DATETIME;
DECLARE @EDate AS DATETIME;
DECLARE @DoEvent AS BIT;
DECLARE @DoLockedSession AS BIT;

SET @SeedDate = '2021-08-01'; --:AGESEEDDATE;
SET @SDate = '2022-01-27'; -- :DTSTART;
SET @EDate = '2022-01-28'; -- :DTEND;
SET @DoEvent = 1;
SET @DoLockedSession = 1;

IF OBJECT_ID('tempdb..#tmp4', 'U') IS NOT NULL
    DROP TABLE #tmp4;

-- build a list of division with it's members
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
SELECT ScoreDivisionId,
       [Event].EventID,
       Entrant.MemberID,
       Entrant.EntrantID,
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

-- CALCULATE POINTS
SELECT #tmp1.ScoreDivisionID,
       #tmp1.MemberID,
       #tmp1.EventID,
       #tmp1.Place,
       #tmp1.EntrantID,
       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Points
INTO #tmp2
FROM #tmp1
    LEFT JOIN ScorePoints
        ON #tmp1.Place = ScorePoints.Place
ORDER BY MemberID ASC;

IF OBJECT_ID('tempdb..#tmp3', 'U') IS NOT NULL
    DROP TABLE #tmp3;

-- CALCULATE TOTAL-SCORE
SELECT #tmp2.ScoreDivisionID,
       #tmp2.MemberID,
       SUM(#tmp2.Points) AS TotalScore
INTO #tmp3
FROM #tmp2
GROUP BY #tmp2.ScoreDivisionID,
         #tmp2.MemberID;

-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT 
SELECT #tmp2.ScoreDivisionID,
       #tmp2.MemberID,
       #tmp2.EventID,
       #tmp3.TotalScore,
       #tmp2.Place,
       #tmp2.Points,
       SUBSTRING(CONCAT(FirstName, ' ', UPPER(LastName)), 0, 50) AS MemberNameStr,
       SUBSTRING(
                    CONCAT(
                              '[',
                              FORMAT(Event.SessionID, '#####'),
                              '.',
                              FORMAT(Event.EventNum, '###'),
                              '] ',
                              Distance.Caption,
                              ' ',
                              Stroke.Caption
                          ),
                    0,
                    50
                ) AS DistStrokeStr,
       ScoreDivision.Caption AS DivisionStr,
       ScoreDivision.GenderID,
       ScoreDivision.AgeTo,
       dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime,
       Entrant.IsDisqualified,
       Entrant.IsScratched,
       [Event].Caption AS EventDetailStr,
       Gender.Caption AS GenderStr
FROM #tmp2
    INNER JOIN #tmp3
        ON #tmp2.ScoreDivisionID = #tmp3.ScoreDivisionID
           AND #tmp2.MemberID = #tmp3.MemberID
    INNER JOIN Member
        ON #tmp2.MemberID = Member.MemberID
    INNER JOIN Event
        ON #tmp2.EventID = [Event].EventID
    INNER JOIN Stroke
        ON Event.StrokeID = Stroke.StrokeID
    INNER JOIN Distance
        ON Event.DistanceID = Distance.DistanceID
    INNER JOIN ScoreDivision
        ON #tmp2.ScoreDivisionID = ScoreDivision.ScoreDivisionID
    INNER JOIN Gender
        ON Member.GenderID = Gender.GenderID
    INNER JOIN Entrant
        ON #tmp2.EntrantID = Entrant.EntrantID


-- NOTE: final sort index applied in FireDAC 
ORDER BY #tmp2.EventID;

DROP TABLE #tmp3;
DROP TABLE #tmp2;
DROP TABLE #tmp1;
DROP TABLE #tmp4;




