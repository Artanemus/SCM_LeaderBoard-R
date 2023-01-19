USE SwimClubMeet;
DECLARE @SDate AS DATETIME;
DECLARE @EDate AS DATETIME;
DECLARE @DoEvent AS BIT;
DECLARE @DoLockedSession AS BIT;

SET @SDate = '2022-01-27'; -- :DTSTART;
SET @EDate = '2022-01-28'; -- :DTEND;
SET @DoEvent = 0;
SET @DoLockedSession = 1;

IF OBJECT_ID('tempdb..#tmp1', 'U') IS NOT NULL
    DROP TABLE #tmp1;

-- build an ordered list of entrants with placings
-- MEMBERS THAT ARE SCRATCH OR DISQUALIFIED score zero
-- by the scalar function ...
SELECT Entrant.MemberID,
       Entrant.EntrantID,
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
    INNER JOIN Event
        ON HeatIndividual.EventID = Event.EventID
    INNER JOIN [Session]
        ON Event.SessionID = [Session].SessionID
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

-- Builds a table with members idS
-- + a score for each placing....
SELECT #tmp1.MemberID,
       dbo.EntrantScore(#tmp1.EntrantID, ScorePoints.Points) AS Points
INTO #tmp2
FROM #tmp1
    LEFT JOIN ScorePoints
        ON #tmp1.Place = ScorePoints.Place
ORDER BY MemberID ASC;

IF OBJECT_ID('tempdb..#tmp3', 'U') IS NOT NULL
    DROP TABLE #tmp3;

-- Tot-up the member's scores - grouped by House
SELECT Member.HouseID,
       SUM(#tmp2.Points) AS HouseScore
INTO #tmp3
FROM #tmp2
    INNER JOIN Member
        ON #tmp2.MemberID = Member.MemberID
GROUP BY Member.HouseID;

-- JOIN ALL THE BITS ON HOUSE - INTO A  SINGLE TABLE 
-- ready for reporting
SELECT #tmp3.HouseID,
       #tmp3.HouseScore,
       House.Caption,
       House.Motto,
       House.Color,
       House.LogoImg
FROM #tmp3
    INNER JOIN House
        ON #tmp3.HouseID = House.HouseID
ORDER BY #tmp3.HouseScore ASC;

DROP TABLE #tmp3;
DROP TABLE #tmp2;
DROP TABLE #tmp1;




