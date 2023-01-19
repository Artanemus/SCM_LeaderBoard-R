unit frmLeaderBoard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Actions,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  frxClass, frxPreview,
  dlgOptions, dmSCM, dlgBasicLogin, dlgSplash, dmReports, frxExportBaseDialog,
  frxExportPDF;

type
  TLeaderBoard = class(TForm)
    Panel1: TPanel;
    pnlSwimClubTitle: TPanel;
    DBtxtSwimClubCaption: TDBText;
    DBtxtSwimClubNickName: TDBText;
    spbMenu: TSpeedButton;
    lblMessage: TLabel;
    spbUpdate: TSpeedButton;
    lblTimeStamp: TLabel;
    spbPrintReport: TSpeedButton;
    spbMemberScores: TSpeedButton;
    spbHouseScores: TSpeedButton;
    spbEventScores: TSpeedButton;
    spbCurrEventStatus: TSpeedButton;
    spbExportPDF: TSpeedButton;
    scmProgressBar: TProgressBar;
    ActionManager1: TActionManager;
    actnMenu: TAction;
    actnMember: TAction;
    actnHouse: TAction;
    actnEvents: TAction;
    actnSession: TAction;
    actnRefresh: TAction;
    actnPrint: TAction;
    actnExportPDF: TAction;
    Timer1: TTimer;
    frxPreview1: TfrxPreview;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    VirtualImageList2: TVirtualImageList;
    SpeedButton1: TSpeedButton;
    actnTimer: TAction;
    spbCurrEventStatus2: TSpeedButton;
    DBtxtStartOfSwimSeason: TDBText;
    frxPDFExport1: TfrxPDFExport;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure spbMenuClick(Sender: TObject);
    procedure spbGenericSPBtnClick(Sender: TObject);
    procedure actnRefreshExecute(Sender: TObject);
    procedure actnRefreshUpdate(Sender: TObject);
    procedure actnExportPDFExecute(Sender: TObject);
    procedure actnExportPDFUpdate(Sender: TObject);
    procedure actnPrintExecute(Sender: TObject);
    procedure actnPrintUpdate(Sender: TObject);
  private
    { Private declarations }
    fSessionID: integer;
    fScoreMode: TScoreMode;
    fCalcModeEntrantAge: TCalcMode;
    fCalcModeSessionRange: TCalcMode;
    fSwimClubID: integer;
    fAgeSeedDate: TDateTime;
    fCustomStartDT: TDateTime;
    fCustomEndDT: TDateTime;

    // I N I T I A L I Z E   :   U T I L I T Y .
    procedure ReadPreferences(iniFileName: string);
    procedure ClearSpeedBtnGroup2();

  public
    { Public declarations }
  end;

var
  LeaderBoard: TLeaderBoard;

implementation

{$R *.dfm}

uses
  System.IniFiles, System.UITypes, Utility, System.DateUtils;

// ----------------------------------------------------
// A C T I O N S . . . .
// ----------------------------------------------------
{$REGION 'ACTIONS'}

procedure TLeaderBoard.actnExportPDFExecute(Sender: TObject);
var
  rpt: TfrxReport;
begin
  if Assigned(RPTS) AND Assigned(frxPreview1) then
  begin
    rpt := frxPreview1.Report;
    if Assigned(rpt) then
      RPTS.ExportReportToPDF(rpt); // export to PDF
  end;
end;

procedure TLeaderBoard.actnExportPDFUpdate(Sender: TObject);
begin
   if frxPreview1.Visible then
      TAction(Sender).Enabled := true
   else
      TAction(Sender).Enabled := false;
end;

procedure TLeaderBoard.actnPrintExecute(Sender: TObject);
var
  rpt: TfrxReport;
begin
  if Assigned(RPTS) AND Assigned(frxPreview1) then
  begin
    rpt := frxPreview1.Report;
    RPTS.PrintReport(rpt);
  end;
end;

procedure TLeaderBoard.actnPrintUpdate(Sender: TObject);
begin
   if frxPreview1.Visible then
      TAction(Sender).Enabled := true
   else
      TAction(Sender).Enabled := false;
end;

procedure TLeaderBoard.actnRefreshExecute(Sender: TObject);
var
  rpt: TfrxReport;
begin
  // identify the current report being viewed, re-prepare and preview.
  if Assigned(RPTS) AND Assigned(frxPreview1) then
  begin
    rpt := frxPreview1.Report;
    if Assigned(rpt) then
    begin
      rpt.PrepareReport;
      rpt.ShowPreparedReport;
    end;
  end;
end;

procedure TLeaderBoard.actnRefreshUpdate(Sender: TObject);
begin
   if frxPreview1.Visible then
      TAction(Sender).Enabled := true
   else
      TAction(Sender).Enabled := false;
end;

procedure TLeaderBoard.ClearSpeedBtnGroup2;
var
  idx: integer;
  cmp: TComponent;
begin
  for idx := 0 to ComponentCount - 1 do
  begin
    cmp := Components[idx];
    if cmp.ClassName = 'TSpeedButton' then
    begin
      if TSpeedButton(cmp).GroupIndex = 2 then
      begin
        if TSpeedButton(cmp).Down then
          TSpeedButton(cmp).Down := false;
      end;
    end;
  end;
end;

{$ENDREGION}

procedure TLeaderBoard.FormCreate(Sender: TObject);
var
  aBasicLogin: TBasicLogin;
  result: TmodalResult;
  iniFileName: string;
begin
  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   S C M .
  // ----------------------------------------------------
  try
    SCM := TSCM.Create(Self);
  finally
    // with SCM created and the essential tables are open then
    // asserting the connection should be true
    if not Assigned(SCM) then
    begin
      MessageDlg('The SCM connection couldn''t be created!', mtError,
        [mbOk], 0);
      Application.Terminate;
    end;
  end;
  if not Assigned(SCM) then
    Exit;
  // ----------------------------------------------------
  // C O N N E C T   T O   S E R V E R .
  // ----------------------------------------------------
  aBasicLogin := TBasicLogin.Create(Self);
  result := aBasicLogin.ShowModal;
  aBasicLogin.Free;

  if (result = mrAbort) or (result = mrCancel) then
  begin
    Application.Terminate;
    Exit;
  end;
  // ----------------------------------------------------
  // C R E A T E   D A T A M O D U L E   R P T S .
  // ----------------------------------------------------
  RPTS := TRPTS.Create(Self);
  if not Assigned(RPTS) then
  begin
    MessageDlg('The FastReport data module couldn''t be created!', mtError,
      [mbOk], 0);
    Application.Terminate;
    Exit;
  end;
  // ----------------------------------------------------
  // A C T I V A T E   S C M  .
  // ----------------------------------------------------
  SCM.ActivateTable();
  // A S S E R T .
  if not SCM.IsActive then
  begin
    MessageDlg('An error occurred during MSSQL table activation.' + sLineBreak +
      'The database''s schema may need updating.' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    FreeAndNil(splash);
    // note: cleans and destroys SCM
    Application.Terminate;
  end;
  // ----------------------------------------------------
  // I N I T I A L I Z E   P A R A M S .
  // ----------------------------------------------------
  Application.ShowHint := true; // enable hints
  scmProgressBar.Position := 0; // Initialization progress bar ...
  fSwimClubID := 1;
  fSessionID := 0; // current selected session.
  fAgeSeedDate := Date; // seed-date to determine an entrants age.
  fCustomStartDT := 0; // custom start date for swimming sessions.
  fCustomEndDT := 0; // custom end date.
  frxPreview1.Visible := false;
  RPTS.Preview := nil; // FastReports preview component.
  // ----------------------------------------------------
  // R E A D   P R E F E R E N C E S .
  // ----------------------------------------------------
  iniFileName := GetSCMPreferenceFileName;
  if FileExists(iniFileName) then
    ReadPreferences(iniFileName)
  else
  begin
    // SCM SYSTEM ERROR : The preference file couldn't be created.
    MessageDlg('An unexpected SCM error occurred.' + sLineBreak +
      'Unable to create the LeaderBoard ini file!' + sLineBreak +
      'The application will terminate!', mtError, [mbOk], 0);
    FreeAndNil(splash);
    // note: cleans and destroys SCM
    Application.Terminate;
  end;
  // ----------------------------------------------------
  // D I S P L A Y   H E A D E R   I N F O .
  // ----------------------------------------------------
  if fSwimClubID <> 0 then
  begin
    SCM.qryLBHeader.Connection := SCM.scmConnection;
    SCM.qryLBHeader.ParamByName('SWIMCLUBID').AsInteger := fSwimClubID;
    SCM.qryLBHeader.Prepare;
    SCM.qryLBHeader.Open;
  end;
  if SCM.qryLBHeader.Active then
  begin
    DBtxtSwimClubCaption.DataSource := SCM.dsLBHeader;
    DBtxtSwimClubNickName.DataSource := SCM.dsLBHeader;
    DBtxtStartOfSwimSeason.DataSource := SCM.dsLBHeader;
  end;
end;

procedure TLeaderBoard.FormDestroy(Sender: TObject);
begin
  // de-activate RPTS (FastReport)
  if Assigned(RPTS) then
  begin
    FreeAndNil(RPTS);
  end;
  // de-activete SCM DataModule
  if Assigned(SCM) then
  begin
    SCM.scmConnection.Close;
    FreeAndNil(SCM);
  end;
end;

procedure TLeaderBoard.ReadPreferences(iniFileName: string);
var
  iFile: TIniFile;
  i: integer;
begin
  iFile := TIniFile.Create(iniFileName);
  // Determines what seed-date is used to calculate the age of entrants.
  i := iFile.ReadInteger('LeaderBoard', 'CalcModeEntrantAge',
    integer(TCalcMode(cmNOTASSIGNED)));
  if (i >= Ord(Low(TCalcMode))) and (i <= Ord(High(TCalcMode))) then
    fCalcModeEntrantAge := TCalcMode(i)
  else
    fCalcModeEntrantAge := cmNOTASSIGNED;
  // Determines what range used to gather up sessions.
  // ie. the swimming season (start of sesaon to  selected session - inclusive)
  // or ... selected session.
  i := iFile.ReadInteger('LeaderBoard', 'CalcModeSessionRange',
    integer(TCalcMode(cmNOTASSIGNED)));
  if (i >= Ord(Low(TCalcMode))) and (i <= Ord(High(TCalcMode))) then
    fCalcModeSessionRange := TCalcMode(i)
  else
    fCalcModeSessionRange := cmNOTASSIGNED;
  // Determines the method for scoring ... ABSOLUTE, RELATIVE - EVENT, HEAT
  i := iFile.ReadInteger('LeaderBoard', 'ScoreMode',
    integer(TScoreMode(smNOTASSIGNED)));
  if (i >= Ord(Low(TScoreMode))) and (i <= Ord(High(TScoreMode))) then
    fScoreMode := TScoreMode(i)
  else
    fScoreMode := smNOTASSIGNED;
  // Current selected session
  fSessionID := iFile.ReadInteger('LeaderBoard', 'SessionID', 0);
  // Custom seed-date used to determine the age of the member.
  fAgeSeedDate := iFile.ReadDate('LeaderBoard', 'AgeSeedDate', Date);
  // Select swimming sessions based on custom range.
  fCustomStartDT := iFile.ReadDate('LeaderBoard', 'DateFrom', 0);
  fCustomEndDT := iFile.ReadDate('LeaderBoard', 'DateTo', 0);
  iFile.Free;
end;

procedure TLeaderBoard.spbGenericSPBtnClick(Sender: TObject);
var
  ERR: TRtnError;
begin
  ERR := TRtnError.reNONE;
  if Assigned(RPTS) then
  begin
    if TSpeedButton(Sender).Down then
    // Enable RPTS preview and display report.
    begin
      RPTS.Preview := frxPreview1;
      if (Assigned(SCM)) and (Assigned(RPTS)) then
      begin
        case TSpeedButton(Sender).Tag of
          1: // MEMBER'S TOTALSCORE, Distance-Stroke.SubTotal
            ERR := RPTS.MemberScores;
          2: // ACCUMALATIVE HOUSE SCORES
            ERR := RPTS.HouseScores;
          3: // EVENTS
            ERR := RPTS.EventScores;
          4: // THE CURRENT SESSION
            // LAST CLOSED-EVENT OR LAST RACED-HEAT OR LAST CLOSED HEAT
            ;
        end;
        case ERR of
          reNONE:
            ;
          reNoSessions:
            MessageDlg('No session found for the given range.',
              TMsgDlgType.mtInformation, [mbOk], 0);
          reSystem:
            MessageDlg('Unknown report display error.',
              TMsgDlgType.mtInformation, [mbOk], 0);
          reNotAssigned:
            MessageDlg('Missing preference, option not assigned.',
              TMsgDlgType.mtInformation, [mbOk], 0);
        end;
      end;
      // was an error found?
      if ERR <> TRtnError.reNONE then
      begin
        frxPreview1.Visible := false;
        ClearSpeedBtnGroup2;
      end
      else
        frxPreview1.Visible := true;
    end
    else
    // Disable RPTS preview and hide.
    begin
      frxPreview1.Visible := false;
      ClearSpeedBtnGroup2;
    end;
  end;
end;

procedure TLeaderBoard.spbMenuClick(Sender: TObject);
var
  dlg: TOptions;
  doRead: boolean;
  iniFileName: string;
begin
  // Options Dialogue
  doRead := false;
  dlg := TOptions.Create(Self);
  if Assigned(dlg) then
  begin
    if IsPositiveResult(dlg.ShowModal) then
      doRead := true;
  end;
  dlg.Free;
  if doRead then
  begin
    iniFileName := GetSCMPreferenceFileName;
    // clear the frx preview screen
    frxPreview1.Visible := false;
    if Assigned(RPTS) then
      RPTS.Preview := nil;
    // reset Group 2 speedbuttons
    ClearSpeedBtnGroup2;
    // reload params
    ReadPreferences(iniFileName);

  end;
end;

end.
