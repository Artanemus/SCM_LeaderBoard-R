object SCM: TSCM
  OnCreate = DataModuleCreate
  Height = 394
  Width = 439
  object scmConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_SwimClubMeet')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 96
    Top = 40
  end
  object qrySwimClub: TFDQuery
    IndexFieldNames = 'SwimClubID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime]
    FormatOptions.FmtDisplayDateTime = 'dd/mm/yy HH:NN'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE [SwimClubMeet];'
      ''
      'DECLARE @SwimClubID AS INT;'
      ''
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'IF @SwimClubID IS NULL'
      #9'SET @SwimClubID = 1;'
      ''
      'SELECT [SwimClubID]'
      #9',[NickName]'
      #9',[Caption]'
      #9',[Email]'
      #9',[ContactNum]'
      #9',[WebSite]'
      #9',[HeatAlgorithm]'
      #9',[EnableTeamEvents]'
      #9',[EnableSwimOThon]'
      #9',[EnableExtHeatTypes]'
      #9',[EnableMembershipStr]'
      #9',[NumOfLanes]'
      #9',[LenOfPool]'
      #9',[StartOfSwimSeason]'
      #9',[CreatedOn]'
      'FROM [dbo].[SwimClub]'
      'WHERE SwimClubID = @SwimClubID;')
    Left = 88
    Top = 160
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsSwimClub: TDataSource
    DataSet = qrySwimClub
    Left = 152
    Top = 160
  end
  object qrySession: TFDQuery
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime]
    FormatOptions.FmtDisplayDateTime = 'dd/mm/yy HH:MM'
    FormatOptions.FmtDisplayDate = 'dd/mm/yyyy'
    FormatOptions.FmtDisplayTime = 'nn:ss.zzz'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'DECLARE @SwimClubID AS INT;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'SELECT Session.SessionID'
      #9',Session.SessionStart'
      #9',Session.SwimClubID'
      #9',Session.SessionStatusID'
      #9',SessionStatus.Caption AS StatusStr'
      #9',Session.Caption'
      'FROM Session'
      
        'LEFT OUTER JOIN SessionStatus ON Session.SessionStatusID = Sessi' +
        'onStatus.SessionStatusID'
      'WHERE SwimClubID = @SwimClubID AND Session.SessionStatusID <> 2'
      'ORDER BY Session.SessionStart DESC')
    Left = 88
    Top = 216
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsSession: TDataSource
    DataSet = qrySession
    Left = 152
    Top = 216
  end
  object qryLBHeader: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SwimClubID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'SwimClubID'
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SwimClubID AS INTEGER;'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      ''
      'SELECT '
      #9#9' [SwimClubID]'
      #9#9',[NickName]'
      #9#9',[Caption]'
      #9#9',[StartOfSwimSeason]'
      
        '        , Concat('#39'Start of swimming season: '#39', Format(StartOfSwi' +
        'mSeason, '#39'MMMM dd, yyyy'#39', '#39'en-AU'#39')) as CaptionStr'
      ''
      '/* '#9#9',[Email]'
      #9#9',[ContactNum]'
      #9#9',[WebSite]'
      #9#9',[HeatAlgorithm]'
      #9#9',[EnableTeamEvents]'
      #9#9',[EnableSwimOThon]'
      #9#9',[EnableExtHeatTypes]'
      #9#9',[EnableMembershipStr]'
      #9#9',[NumOfLanes]'
      #9#9',[LenOfPool]'
      #9#9',[CreatedOn] */'
      'FROM [SwimClubMeet].[dbo].[SwimClub]'
      'WHERE SwimClubID = @SwimClubID; ')
    Left = 88
    Top = 104
    ParamData = <
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
  object dsLBHeader: TDataSource
    AutoEdit = False
    DataSet = qryLBHeader
    Left = 151
    Top = 104
  end
  object qryGetStartOfSession: TFDQuery
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      'DECLARE @SessionID AS INTEGER;'
      'SET @SessionID = :SESSIONID;'
      ''
      
        '-- Select rows from a Table or View '#39'[Session]'#39' in schema '#39'[dbo]' +
        #39
      'SELECT SessionStart'
      'FROM [dbo].[Session]'
      'WHERE SessionID = @SessionID;')
    Left = 304
    Top = 64
    ParamData = <
      item
        Name = 'SESSIONID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 70
      end>
  end
  object dsGetStartOfSession: TDataSource
    DataSet = qryGetStartOfSession
    Left = 304
    Top = 112
  end
  object qryHeatStatus: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT HeatStatusID, Caption FROM HeatStatus;')
    Left = 88
    Top = 288
  end
  object dsHeatStatus: TDataSource
    DataSet = qryHeatStatus
    Left = 160
    Top = 288
  end
  object qryGetSessionCount: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'DECLARE @SDate AS DATETIME;'
      'DECLARE @EDate AS DATETIME;'
      'DECLARE @SwimClubID AS INTEGER;'
      ''
      ''
      'SET @SDate = :SDATE; --'#39'2021-01-01'#39';'
      'SET @EDate = :EDATE; --'#39'2022-01-20'#39';'
      'SET @SwimClubID = :SWIMCLUBID;'
      ''
      'WITH myCTE'
      'AS (SELECT COUNT(*) AS RowsInView'
      '    FROM [dbo].[Session]'
      '    WHERE [Session].SessionStart >= @SDate'
      
        '          AND [Session].SessionStart <= @EDate AND [Session].Swi' +
        'mClubID = @SwimClubID)'
      'SELECT myCTE.RowsInView AS SessionCount'
      'FROM myCTE;')
    Left = 304
    Top = 200
    ParamData = <
      item
        Name = 'SDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EDATE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SWIMCLUBID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
  end
end
