USE SwimClubMeet;
DECLARE @SDate AS DATETIME;
DECLARE @EDate AS DATETIME;
DECLARE @DoEvent AS BIT;
DECLARE @DoLockedSession AS BIT;

SET @SDate = '2022-01-27'; -- :DTSTART; --'2022-01-27'; 
SET @EDate = '2022-01-28'; -- :DTEND; --'2022-01-28'; 
SET @DoEvent = 1;
SET @DoLockedSession = 1;


IF OBJECT_ID('tempdb..#tmp1', 'U') IS NOT NULL
    DROP TABLE #tmp1;

-- CALCULATE PLACE
SELECT [Event].EventID,
       Entrant.MemberID,
       Entrant.EntrantID,
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
    INNER JOIN Event
        ON HeatIndividual.EventID = Event.EventID
    INNER JOIN Session
        ON Event.SessionID = Session.SessionID
WHERE Session.SessionStart >= @SDate
      AND Session.SessionStart <= @EDate
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
SELECT #tmp1.EventID,
       #tmp1.MemberID,
       #tmp1.EntrantID,
       #tmp1.Place,
       dbo.EntrantScore(#tmp1.EntrantID, #tmp1.Place) AS Points
INTO #tmp2
FROM #tmp1
    LEFT JOIN ScorePoints
        ON #tmp1.Place = ScorePoints.Place
ORDER BY MemberID ASC;


-- JOIN ALL THE BITS TO CREATE THE FINAL SELECT 
SELECT #tmp2.EventID,
       #tmp2.MemberID,
       #tmp2.EntrantID,
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
       [Event].EventNum,
       dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTime,
       Entrant.IsDisqualified,
       Entrant.IsScratched,
       Gender.GenderID,
       Gender.Caption
FROM #tmp2
    INNER JOIN Member
        ON #tmp2.MemberID = Member.MemberID
    INNER JOIN Event
        ON #tmp2.EventID = Event.EventID
    INNER JOIN Stroke
        ON Event.StrokeID = Stroke.StrokeID
    INNER JOIN Distance
        ON Event.DistanceID = Distance.DistanceID
    INNER JOIN Entrant
        ON #tmp2.EntrantID = Entrant.EntrantID
    INNER JOIN Gender
        ON Member.GenderID = Gender.GenderID
ORDER BY Gender.GenderID DESC;

DROP TABLE #tmp2;
DROP TABLE #tmp1;




