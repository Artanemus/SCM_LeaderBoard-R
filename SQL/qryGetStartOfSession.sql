USE SwimClubMeet;
DECLARE @SessionID AS INTEGER;
SET @SessionID = 70; -- :SESSIONID;

-- Select rows from a Table or View '[Session]' in schema '[dbo]'
SELECT SessionStart
FROM [dbo].[Session]
WHERE SessionID = @SessionID;