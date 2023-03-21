unit dmSCM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, System.Variants, DateUtils;

type
  TSCM = class(TDataModule)
    scmConnection: TFDConnection;
    qrySwimClub: TFDQuery;
    dsSwimClub: TDataSource;
    qrySession: TFDQuery;
    dsSession: TDataSource;
    qryLBHeader: TFDQuery;
    dsLBHeader: TDataSource;
    qryGetStartOfSession: TFDQuery;
    dsGetStartOfSession: TDataSource;
    qryHeatStatus: TFDQuery;
    dsHeatStatus: TDataSource;
    qryGetSessionCount: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }
    FIsActive: boolean;

  public
    { Public declarations }
    function GetStartOfSwimmingSeason(SwimClubID: integer): TDateTime;
    function GetStartOfSession(SessionID: integer): TDateTime;
    function GetSessionCount(SwimClubID: integer; SDate, EDate: TDateTime): Integer;
    procedure ActivateTable();
    procedure SimpleLoadSettingString(ASection, AName: string; var AValue: string);
    procedure SimpleMakeTemporyFDConnection(Server, User, Password: string;
      OsAuthent: boolean);
    procedure SimpleSaveSettingString(ASection, AName, AValue: string);
    property IsActive: boolean read FIsActive write FIsActive;
  end;

const
  SCMCONFIGFILENAME = 'SCMConfig.ini';

var
  SCM: TSCM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  System.IOUtils, IniFiles;

{$REGION  SIMPLE TEMPORY CONNECTION AND INIFILES CONFIGURATION}

procedure TSCM.ActivateTable;
begin
  // TODO: activate all the tables on the form ?....
  qryHeatStatus.Active := true;
  FIsActive := true;
end;

procedure TSCM.DataModuleCreate(Sender: TObject);
begin
  ActivateTable;
end;

function TSCM.GetSessionCount(SwimClubID: integer; SDate,
  EDate: TDateTime): Integer;
begin
  result := 0;
  if qryGetSessionCount.Active then
    qryGetSessionCount.Close;
  qryGetSessionCount.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
  qryGetSessionCount.ParamByName('SDATE').AsDateTime := SDate;
  qryGetSessionCount.ParamByName('EDATE').AsDateTime := EDate;
  qryGetSessionCount.Prepare;
  qryGetSessionCount.Open;
  if qryGetSessionCount.Active then
  begin
    if not qryGetSessionCount.IsEmpty then
    begin
      result := qryGetSessionCount.FieldByName('SessionCount').AsInteger;
    end;
  end;

end;

function TSCM.GetStartOfSession(SessionID: integer): TDateTime;
begin
  result := Date;
    if qryGetStartOfSession.Active then
      qryGetStartOfSession.Close;
    qryGetStartOfSession.ParamByName('SESSIONID').AsInteger := SessionID;
    qryGetStartOfSession.Prepare;
    qryGetStartOfSession.Open;
    if qryGetStartOfSession.Active then
    begin
      if not qryGetStartOfSession.IsEmpty then
      begin
        result := qryGetStartOfSession.FieldByName('SessionStart').AsDateTime;
      end;
    end;
end;

function TSCM.GetStartOfSwimmingSeason(SwimClubID: integer): TDateTime;
var
  dt: TDateTime;
begin
  result := Date();
  if SwimClubID > 0 then
  begin
    if qrySwimClub.Active then
      qrySwimClub.Close;
    qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := SwimClubID;
    qrySwimClub.Prepare;
    qrySwimClub.Open;
    if qrySwimClub.Active then
    begin
      if not qrySwimClub.IsEmpty then
      begin
        dt := qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
        // If ANow and AThen are two and a half years apart,
        // calling WithinPastYears with AYears set to 2 returns True.
        if WithinPastYears(result, dt, 1) then
          result := dt;
      end;
    end;
  end;
end;

procedure TSCM.SimpleLoadSettingString(ASection, AName: string; var AValue: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    AValue := ini.ReadString(ASection, Aname, '');
  finally
    ini.Free;
  end;
end;

procedure TSCM.SimpleMakeTemporyFDConnection(Server, User, Password: string;
  OsAuthent: boolean);
var
  AValue, ASection, AName: string;
begin
  if (scmConnection.Connected) then
  begin
    scmConnection.Close();
  end;

  scmConnection.Params.Add('Server=' + Server);
  scmConnection.Params.Add('DriverID=MSSQL');
  scmConnection.Params.Add('Database=SwimClubMeet');
  scmConnection.Params.Add('User_name=' + User);
  scmConnection.Params.Add('Password=' + Password);
  if (OsAuthent) then
    AValue := 'Yes'
  else
    AValue := 'No';
  scmConnection.Params.Add('OSAuthent=' + AValue);
  scmConnection.Params.Add('Mars=yes');
  scmConnection.Params.Add('MetaDefSchema=dbo');
  scmConnection.Params.Add('ExtendedMetadata=False');
  scmConnection.Params.Add('ApplicationName=scmTimeKeeper');
  scmConnection.Connected := true;

  // ON SUCCESS - Save connection details.
  if (scmConnection.Connected) then
  begin
    ASection := 'MSSQL_SwimClubMeet';
    AName := 'Server';
    SimpleSaveSettingString(ASection, AName, Server);
    AName := 'User';
    SimpleSaveSettingString(ASection, AName, User);
    AName := 'Password';
    SimpleSaveSettingString(ASection, AName, Password);
    AName := 'OSAuthent';
    SimpleSaveSettingString(ASection, AName, AValue);
  end
end;

procedure TSCM.SimpleSaveSettingString(ASection, AName, AValue: string);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(TPath.GetDocumentsPath + PathDelim +
    SCMCONFIGFILENAME);
  try
    ini.WriteString(ASection, AName, AValue);
  finally
    ini.Free;
  end;

end;

{$REGION end}

end.
