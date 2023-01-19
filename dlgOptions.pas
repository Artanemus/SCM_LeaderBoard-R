unit dlgOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Vcl.VirtualImage, Vcl.BaseImageCollection, Vcl.ImageCollection,
  Vcl.WinXPickers, Vcl.WinXCalendars, Vcl.PlatformDefaultStyleActnCtrls,
  System.Actions, Vcl.ActnList, Vcl.ActnMan, Vcl.DBCtrls;

type
  TScoreMode = (smNOTASSIGNED, smABSEvent, smABSHeat, smRELEvent, smRELHeat);
  TCalcMode = (cmNOTASSIGNED, cmStartOfSeason, cmStartOfSession, cmCustomDT);

  TOptions = class(TForm)
    lblSessionCaption: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblStartOfSwimmingSeacon: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    lblAutoUpdate1: TLabel;
    lblAutoUpdate2: TLabel;
    Panel1: TPanel;
    btnClose: TButton;
    cbSessionStart: TComboBox;
    cbxCalcEntrantAge: TComboBox;
    cbxCalcByEvent: TComboBox;
    cbxCalcRange: TComboBox;
    cbxCalcRelative: TComboBox;
    spinedtAutoUpdateInterval: TSpinEdit;
    chbxAutoUpdate: TCheckBox;
    btnCancel: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ImageCollection1: TImageCollection;
    Label11: TLabel;
    Label12: TLabel;
    imgDateFrom: TVirtualImage;
    imgDateTo: TVirtualImage;
    imgAgeSeedDate: TVirtualImage;
    calDateFrom: TCalendarPicker;
    calDateTo: TCalendarPicker;
    calAgeSeedDate: TCalendarPicker;
    ActionList1: TActionList;
    actnAutoUpdate: TAction;
    actnCustomRange: TAction;
    vimgAutoUpdate: TVirtualImage;
    cbxIncludeLockedSessions: TCheckBox;
    Label1: TLabel;
    CheckBox2: TCheckBox;
    ComboBox1: TComboBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbSessionStartChange(Sender: TObject);
    procedure cbxCalcRangeChange(Sender: TObject);
    procedure imgDateFromClick(Sender: TObject);
    procedure imgDateToClick(Sender: TObject);
    procedure imgAgeSeedDateClick(Sender: TObject);
    procedure actnAutoUpdateExecute(Sender: TObject);
    procedure actnAutoUpdateUpdate(Sender: TObject);
    procedure vimgAutoUpdateClick(Sender: TObject);

  private
    { Private declarations }
    // PARAM's written to iniFile.
    fSessionID: Integer;
    fScoreMode: TScoreMode;
    fCalcModeEntrantAge: TCalcMode;
    fCalcModeRange: TCalcMode;
    fEnableAutoUpdate: Boolean;

    // local param's
    fSwimClubID: Integer;
    // PROPERTIES SET/GET
    function GetSessionID(): Integer;
    function GetSessionCaption(): string;
    function GetScoreMode(): TScoreMode;
    procedure SetScoreMode(Value: TScoreMode);

    function GetSwimClubID(): Integer;
    function GetSessionStart(): TDateTime;
    function GetStartOfSwimmingSeason(): TDateTime;

    // CONVERT FROM COMPONENT TO ENUM AND VISA-VERSA
    function CnvCBXtoScoreMode(): TScoreMode;
    function CnvEntrantAgetoCalcMode(): TCalcMode;
    function CnvRangetoCalcMode(): TCalcMode;
    procedure CnvScoreModeToCBX(Value: TScoreMode);
    procedure CnvCalcModeToEntrantAge(Value: TCalcMode);
    procedure CnvCalcModeToRange(Value: TCalcMode);

    procedure BuildSessionComboBox(SwimClubID: Integer);
    procedure ClearSessionComboBox();
    procedure UpdateStartOfSwimmingSeason();

    // P R E F E R E N C E   F I L E   A C C E S S .
    procedure ReadPreferences(iniFileName: string);
    procedure WritePreferneces(iniFileName: string);

  public
    { Public declarations }
    property SwimClubID: Integer read fSwimClubID;
    property SessionID: Integer read GetSessionID;
    property SessionCaption: string read GetSessionCaption;
    property EnableAutoUpdate: Boolean read fEnableAutoUpdate;
    // enumerations ...
    property CalcModeEntrantAge: TCalcMode read fCalcModeEntrantAge;
    property CalcModeRange: TCalcMode read fCalcModeRange;
    property ScoreMethod: TScoreMode read GetScoreMode write SetScoreMode;

  end;

type
  TcmbxObj = class(TObject)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    SessionID, SwimClubID: Integer;
    SessionStart: TDateTime;
    Caption: string;
  end;

var
  Options: TOptions;

implementation

{$R *.dfm}

uses dmSCM, FireDAC.Stan.Param, System.UITypes, Utility, IniFiles;

procedure TOptions.actnAutoUpdateExecute(Sender: TObject);
begin
  fEnableAutoUpdate := TAction(Sender).Checked;
end;

procedure TOptions.actnAutoUpdateUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := TAction(Sender).Checked;
  spinedtAutoUpdateInterval.Enabled := b;
  lblAutoUpdate1.Enabled := b;
  lblAutoUpdate2.Enabled := b;
  if b then
    vimgAutoUpdate.ImageIndex := 6
  else
    vimgAutoUpdate.ImageIndex := 5;

end;

procedure TOptions.btnCancelClick(Sender: TObject);
begin
  // Cancel and exit
  ModalResult := TButton(Sender).ModalResult;
end;

procedure TOptions.BuildSessionComboBox(SwimClubID: Integer);
var
  SessionStartStr: string;
  obj: TcmbxObj;

begin
  if (SwimClubID > 0) and Assigned(SCM) then
  begin
    // CALL MS SQLEXPRESS AND PULL SESSIONS
    if (SCM.qrySession.Active) then
    begin
      SCM.qrySession.Close();
    end;
    SCM.qrySession.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    SCM.qrySession.Prepare();
    SCM.qrySession.Open();
    if SCM.qrySession.Active then
    begin
      with SCM.qrySession do
      begin
        while not EOF do
        begin
          SessionStartStr := FormatDateTime('dd/mm/yy HH:nn',
            FieldByName('SessionStart').AsDateTime);
          obj := TcmbxObj.create;
          obj.SessionID := FieldByName('SessionID').AsInteger;
          obj.SwimClubID := FieldByName('SwimClubID').AsInteger;
          obj.SessionStart := FieldByName('SessionStart').AsDateTime;
          obj.Caption := FieldByName('Caption').AsString;
          cbSessionStart.Items.AddObject(SessionStartStr, obj);
          Next;
        end;
      end;
      SCM.qrySession.Close();
    end;
  end;
end;

procedure TOptions.cbSessionStartChange(Sender: TObject);
var
  obj: TcmbxObj;

begin
  if cbSessionStart.ItemIndex = -1 then
  begin
    fSessionID := 0;
  end
  else
  begin
    obj := TcmbxObj(cbSessionStart.Items.Objects[cbSessionStart.ItemIndex]);
    if Assigned(obj) then
    begin
      fSessionID := obj.SessionID;
      lblSessionCaption.Caption := obj.Caption;
    end;
  end;
end;

procedure TOptions.cbxCalcRangeChange(Sender: TObject);
begin
  if TComboBox(Sender).Name = 'cbxCalcCurrSession' then
  begin
    if TComboBox(Sender).ItemIndex = 0 then
    begin
      // 'Start of season to selected' not available
      MessageDlg('This option isn''t currently available.', mtInformation,
        [mbOK], 0, mbOK);
      TComboBox(Sender).ItemIndex := 1;
    end;
  end;
end;

procedure TOptions.ClearSessionComboBox;
var
  i: Integer;
begin
  for i := 0 to cbSessionStart.Items.Count - 1 do
  begin
    if Assigned(cbSessionStart.Items.Objects[i]) then
    begin
      FreeAndNil(cbSessionStart.Items.Objects[i]);
    end;
  end;
end;

procedure TOptions.CnvScoreModeToCBX(Value: TScoreMode);
begin
  // ABS 0 ; EVENT 1
  case Value of
    smABSEvent:
      begin
        cbxCalcByEvent.ItemIndex := 1;
        cbxCalcRelative.ItemIndex := 0
      end;
    smRELEvent:
      begin
        cbxCalcByEvent.ItemIndex := 1;
        cbxCalcRelative.ItemIndex := 1;
      end;
    smRELHeat:
      begin
        cbxCalcByEvent.ItemIndex := 0;
        cbxCalcRelative.ItemIndex := 1;
      end;
    smABSHeat:
      begin
        cbxCalcByEvent.ItemIndex := 0;
        cbxCalcRelative.ItemIndex := 0;
      end;
  else
    begin
      cbxCalcByEvent.ItemIndex := -1;
      cbxCalcRelative.ItemIndex := -1;
    end;

  end;
end;

procedure TOptions.CnvCalcModeToEntrantAge(Value: TCalcMode);
begin
  case Value of
    cmNOTASSIGNED:
      cbxCalcEntrantAge.ItemIndex := -1;
    cmStartOfSeason:
      cbxCalcEntrantAge.ItemIndex := 0;
    cmStartOfSession:
      cbxCalcEntrantAge.ItemIndex := 1;
    cmCustomDT:
      cbxCalcEntrantAge.ItemIndex := 2;
  else
    cbxCalcEntrantAge.ItemIndex := -1;
  end;
end;

procedure TOptions.CnvCalcModeToRange(Value: TCalcMode);
begin
  case Value of
    cmNOTASSIGNED:
      cbxCalcRange.ItemIndex := -1;
    cmStartOfSeason:
      cbxCalcRange.ItemIndex := 0;
    cmStartOfSession:
      cbxCalcRange.ItemIndex := 1;
    cmCustomDT:
      cbxCalcRange.ItemIndex := 2;
  else
    cbxCalcRange.ItemIndex := -1
  end;
end;

function TOptions.CnvCBXtoScoreMode: TScoreMode;
begin
  // enum ScoreMode {ABSEvent, ABSHeat, RELEvent, RELHeat, smERROR};
  // ABS 0 ; EVENT 1
  result := smNOTASSIGNED;
  if (cbxCalcByEvent.ItemIndex = 1) and (cbxCalcRelative.ItemIndex = 0) then
    result := smABSEvent;
  if (cbxCalcByEvent.ItemIndex = 0) and (cbxCalcRelative.ItemIndex = 0) then
    result := smABSHeat;
  if (cbxCalcByEvent.ItemIndex = 1) and (cbxCalcRelative.ItemIndex = 1) then
    result := smRELEvent;
  if (cbxCalcByEvent.ItemIndex = 0) and (cbxCalcRelative.ItemIndex = 1) then
    result := smRELHeat;
end;

function TOptions.CnvEntrantAgetoCalcMode: TCalcMode;
begin
  case cbxCalcEntrantAge.ItemIndex of
    0:
      result := cmStartOfSeason;
    1:
      result := cmStartOfSession;
    2:
      result := cmCustomDT;
  else
    result := cmNOTASSIGNED
  end;
end;

function TOptions.CnvRangetoCalcMode: TCalcMode;
begin
  case cbxCalcRange.ItemIndex of
    0:
      result := cmStartOfSeason;
    1:
      result := cmStartOfSession;
    2:
      result := cmCustomDT;
  else
    result := cmNOTASSIGNED
  end;

end;

procedure TOptions.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    // a session needs to be selected to use these calculation modes ...
    if (fCalcModeRange = cmStartOfSeason) or (fCalcModeRange = cmStartOfSession)
      or (fCalcModeEntrantAge = cmStartOfSeason) or
      (fCalcModeEntrantAge = cmStartOfSession) then
    begin
      if cbSessionStart.ItemIndex = -1 then
      begin
        MessageDlg('Please select a session.', TMsgDlgType.mtError,
          [mbOK], 0, mbOK);
        CanClose := false;
      end;
    end;

    { TODO -oBSA -cGeneral : CloseQuery - test custom dates }

  end;
end;

procedure TOptions.FormCreate(Sender: TObject);
var
  iniFileName: string;
  i: Integer;
  obj: TcmbxObj;
begin
  // DEFAULT PARAMS
  fSwimClubID := GetSwimClubID();
  fScoreMode := smNOTASSIGNED;
  fCalcModeEntrantAge := cmNOTASSIGNED;
  fCalcModeRange := cmNOTASSIGNED;
  cbSessionStart.ItemIndex := -1;
  lblStartOfSwimmingSeacon.Caption := '';
  lblSessionCaption.Caption := '';

  // DATAMODULE must be valid!
  BuildSessionComboBox(fSwimClubID);

  // read from preference file
  iniFileName := GetSCMPreferenceFileName();
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName)
  else
  begin
    // SCM SYSTEM ERROR : The preference file couldn't be created.
    MessageDlg('An unexpected SCM error occurred.' + sLineBreak +
      'Unable to read the LeaderBoard ini file!' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    Close;
  end;

  // Syncronize the combox boxes to match fScoreMode.
  CnvScoreModeToCBX(fScoreMode);
  CnvCalcModeToEntrantAge(fCalcModeEntrantAge);
  CnvCalcModeToRange(fCalcModeRange);
  // Syncronize session combobox.
  for i := 0 to cbSessionStart.Items.Count - 1 do
  begin
    obj := TcmbxObj(cbSessionStart.Items.Objects[i]);
    if obj.SessionID = fSessionID then
    begin
      cbSessionStart.ItemIndex := i;
      break;
    end;
  end;
  lblSessionCaption.Caption := GetSessionCaption;
  if Assigned(SCM) then
  begin
    UpdateStartOfSwimmingSeason;
  end;

end;

procedure TOptions.FormDestroy(Sender: TObject);
var
  iniFileName: string;
  obj: TcmbxObj;
begin
  if ModalResult <> mrCancel then
  begin
    // Syncronize state of fScoreMode with comboBox selection.
    fScoreMode := CnvCBXtoScoreMode;
    fCalcModeEntrantAge := CnvEntrantAgetoCalcMode;
    fCalcModeRange := CnvRangetoCalcMode;
    fSessionID := 0;

    if cbSessionStart.ItemIndex <> -1 then
    begin
      obj := TcmbxObj(cbSessionStart.Items.Objects[cbSessionStart.ItemIndex]);
      if Assigned(obj) then
      begin
        fSessionID := obj.SessionID;
      end;
    end;
    // write out values
    iniFileName := GetSCMPreferenceFileName();
    if FileExists(iniFileName) then
      WritePreferneces(iniFileName);
  end;
  // Clear the Session ComboBox of objects associated with but
  // not owned in the 'Items' TStrings param.
  ClearSessionComboBox;
end;

function TOptions.GetScoreMode: TScoreMode;
begin
  fScoreMode := CnvCBXtoScoreMode;
  result := fScoreMode;
end;

function TOptions.GetSessionStart: TDateTime;
var
  obj: TObject;
begin
  result := 0; // default.1899-12-30
  if cbSessionStart.ItemIndex <> -1 then
  begin
    obj := cbSessionStart.Items.Objects[cbSessionStart.ItemIndex];
    if Assigned(obj) then
      result := TcmbxObj(obj).SessionStart;
  end;
end;

function TOptions.GetStartOfSwimmingSeason: TDateTime;
begin
  result := 0; // default.1899-12-30
  if Assigned(SCM) then
  begin
    // CALL MS SQLEXPRESS AND PULL SESSIONS
    if (SCM.qrySwimClub.Active) then
      SCM.qrySwimClub.Close();
    SCM.qrySwimClub.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    SCM.qrySwimClub.Prepare();
    SCM.qrySwimClub.Open();
    if SCM.qrySwimClub.Active then
    begin
      if SCM.qrySwimClub.RecordCount > 0 then
      begin
        result := SCM.qrySwimClub.FieldByName('StartOfSwimSeason').AsDateTime;
      end;
    end;
    SCM.qrySwimClub.Close();
  end;
end;

function TOptions.GetSessionCaption: string;
var
  obj: TObject;
begin
  result := ''; // default.empty
  if cbSessionStart.ItemIndex <> -1 then
  begin
    obj := cbSessionStart.Items.Objects[cbSessionStart.ItemIndex];
    if Assigned(obj) then
      result := TcmbxObj(obj).Caption;
  end;
end;

function TOptions.GetSessionID: Integer;
var
  obj: TObject;
begin
  result := 0; // default.0
  if cbSessionStart.ItemIndex <> -1 then
  begin
    obj := cbSessionStart.Items.Objects[cbSessionStart.ItemIndex];
    if Assigned(obj) then
      result := TcmbxObj(obj).SessionID;
  end;
end;

function TOptions.GetSwimClubID: Integer;
var
  obj: TObject;
begin
  begin
    result := 1; // default.1
    if cbSessionStart.ItemIndex <> -1 then
    begin
      obj := cbSessionStart.Items.Objects[cbSessionStart.ItemIndex];
      if Assigned(obj) then
        result := TcmbxObj(obj).SessionID;
    end;
  end;
end;

procedure TOptions.imgAgeSeedDateClick(Sender: TObject);
begin
  calAgeSeedDate.Date := Date;
end;

procedure TOptions.imgDateFromClick(Sender: TObject);
begin
  calDateFrom.Date := Date;
end;

procedure TOptions.imgDateToClick(Sender: TObject);
begin
  calDateTo.Date := Date;
end;

procedure TOptions.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
  i: Integer;
begin
  iFile := TIniFile.create(iniFileName);

  // Determines what seed-date is used to calculate the age of entrants.
  i := iFile.ReadInteger('LeaderBoard', 'CalcModeEntrantAge',
    Integer(TCalcMode(cmNOTASSIGNED)));
  if (i >= Ord(Low(TCalcMode))) and (i <= Ord(High(TCalcMode))) then
    fCalcModeEntrantAge := TCalcMode(i)
  else
    fCalcModeEntrantAge := cmNOTASSIGNED;

  // Determines what range used to calculate the scores.
  // ie. the swimming season (start of sesaon to  selected session - inclusive)
  // or ... selected session.
  i := iFile.ReadInteger('LeaderBoard', 'CalcModeSessionRange',
    Integer(TCalcMode(cmNOTASSIGNED)));
  if (i >= Ord(Low(TCalcMode))) and (i <= Ord(High(TCalcMode))) then
    fCalcModeRange := TCalcMode(i)
  else
    fCalcModeRange := cmNOTASSIGNED;

  // Determines the method for scoring ... ABSOLUTE, RELATIVE - EVENT, HEAT
  i := iFile.ReadInteger('LeaderBoard', 'ScoreMode',
    Integer(TScoreMode(smNOTASSIGNED)));
  if (i >= Ord(Low(TScoreMode))) and (i <= Ord(High(TScoreMode))) then
    fScoreMode := TScoreMode(i)
  else
    fScoreMode := smNOTASSIGNED;

  fSessionID := iFile.ReadInteger('LeaderBoard', 'SessionID', 0);

  // CUSTOM DATE RANGES
  calDateFrom.Date := iFile.ReadDate('LeaderBoard', 'DateFrom', Date);
  calDateTo.Date := iFile.ReadDate('LeaderBoard', 'DateTo', Date);
  calAgeSeedDate.Date := iFile.ReadDate('LeaderBoard', 'AgeSeedDate', Date);

  // AUTO UPDATE
  actnAutoUpdate.Checked := iFile.ReadBool('LeaderBoard',
    'EnableAutoUpdate', false);
  spinedtAutoUpdateInterval.Value := iFile.ReadInteger('LeaderBoard',
    'AutoUpdateInterval', 0);

    // MISC
  cbxIncludeLockedSessions.Checked := iFile.ReadBool('LeaderBoard',
    'IncludeLockedSessions', false);

  iFile.Free;
end;

procedure TOptions.SetScoreMode(Value: TScoreMode);
begin
  fScoreMode := Value;
  CnvScoreModeToCBX(fScoreMode);
end;

procedure TOptions.UpdateStartOfSwimmingSeason();
var
  dt: TDateTime;
begin
  dt := GetStartOfSwimmingSeason;
  if dt > 0 then
    lblStartOfSwimmingSeacon.Caption := FormatDateTime('ddd dd mmmm yyyy', dt)
  else
    lblStartOfSwimmingSeacon.Caption := '';
end;

procedure TOptions.vimgAutoUpdateClick(Sender: TObject);
begin
  actnAutoUpdate.Execute;
end;

procedure TOptions.WritePreferneces(iniFileName: string);
var
  iFile: TIniFile;
begin
  iFile := TIniFile.create(iniFileName);
  iFile.WriteInteger('LeaderBoard', 'CalcModeEntrantAge',
    Integer(fCalcModeEntrantAge));
  iFile.WriteInteger('LeaderBoard', 'CalcModeSessionRange',
    Integer(fCalcModeRange));
  iFile.WriteInteger('LeaderBoard', 'ScoreMode', Integer(fScoreMode));
  iFile.WriteInteger('LeaderBoard', 'SessionID', fSessionID);

  // CUSTOM DATE RANGES
  iFile.WriteDate('LeaderBoard', 'DateFrom', calDateFrom.Date);
  iFile.WriteDate('LeaderBoard', 'DateTo', calDateTo.Date);
  iFile.WriteDate('LeaderBoard', 'AgeSeedDate', calAgeSeedDate.Date);

  // AUTO UPDATE ...
  iFile.WriteBool('LeaderBoard', 'EnableAutoUpdate', actnAutoUpdate.Checked);
  iFile.WriteInteger('LeaderBoard', 'AutoUpdateInterval',
    spinedtAutoUpdateInterval.Value);

   // MISC
   iFile.WriteBool('LeaderBoard', 'IncludeLockedSessions', cbxIncludeLockedSessions.Checked);

  iFile.Free;
end;

end.
